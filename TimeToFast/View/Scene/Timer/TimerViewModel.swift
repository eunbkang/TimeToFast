//
//  TimerViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/04.
//

import Foundation
import RealmSwift

final class TimerViewModel {
    var timeCounter = Observable("00:00:00")
    var timerSetting = Observable(TimerSetting(plan: .sixteen, fastStartTime: Date(), fastEndTime: Date()+3600*16))
    var fastState = Observable(FastState.idle)
    lazy var recordCardTime = Observable(RecordCardTime(
        start: timerSetting.value.fastStartTime.dateToTimeOnlyString(),
        end: timerSetting.value.fastEndTime.dateToTimeOnlyString()
    ))
    
    var recordStatus = Observable(RecordStatus.notSaved)
    var isStartTimeEditable = Observable(false)
    var isEndTimeEditable = Observable(false)
    
    private var timer: Timer?
    
    private let notification = NotificationManager.shared
    private let userDefaults = UserDefaultsManager.shared
    private let repository = FastingRecordRepository.shared
    
    private var recordResults: Results<FastingRecordTable>? {
        get {
            return repository?.recordList
        }
    }
    
    var recordList: Observable<[FastingRecordTable]> = Observable([])
    
    // MARK: - methods
    
    func getStoredSetting() {
        configTimerSetting()
        configFastState()
        configRecordCardTime()
        configTimeViewEditable()
        fetchFastingRecord()
        configRecordStatus()
        
        if fastState.value != .idle {
            startTimer()
        }
    }
    
    private func configFastState() {
        fastState.value = userDefaults.isTimerRunning ? fastingOrEating() : .idle
    }
    
    private func fastingOrEating() -> FastState {
        let current = Date()
        if isPlusOneDayRequired() {
            userDefaults.isFastingEarly = false
            userDefaults.isFastingBreak = false
        }
        
        if current < timerSetting.value.fastEndTime {
            if userDefaults.isFastingBreak {
                return .fastingBreak
            } else if userDefaults.isFastingEarly {
                return .fastingEarly
            } else {
                return .fasting
            }
        } else {
            return .eating
        }
    }
    
    func configRecordCardTime() {
        switch fastState.value {
        case .idle:
            if !userDefaults.isTimerRunning {
                setIdleRecordCardTime()
            }
        case .fasting, .fastingBreak, .fastingEarly:
            setFastingRecordCardTime()
        case .eating:
            setEatingRecordCardTime()
        }
    }
    
    private func setIdleRecordCardTime() {
        let startTimeFromTimer = timerSetting.value.fastStartTime
        let endTimeFromTimer = timerSetting.value.fastEndTime
        
        recordCardTime.value.start = startTimeFromTimer.dateToTimeOnlyString()
        recordCardTime.value.end = endTimeFromTimer.dateToTimeOnlyString()
        userDefaults.recordStartTime = startTimeFromTimer
        userDefaults.recordEndTime = endTimeFromTimer
    }
    
    private func setFastingRecordCardTime() {
        let isStartTimeZero = userDefaults.recordStartTime.timeIntervalSince1970 == 0
        let startTimeFromTimer = timerSetting.value.fastStartTime.dateToSetTimeString()
        let startTimeFromUserDefaults = userDefaults.recordStartTime.dateToSetTimeString()
        
        recordCardTime.value.start = isStartTimeZero ? startTimeFromTimer : startTimeFromUserDefaults
        
        if fastState.value == .fasting || fastState.value == .fastingEarly {
            recordCardTime.value.end = timerSetting.value.fastEndTime.dateToSetTimeString()
            
        } else if fastState.value == .fastingBreak {
            recordCardTime.value.end = userDefaults.recordEndTime.dateToSetTimeString()
        }
        
        if isStartTimeZero {
            userDefaults.recordStartTime = timerSetting.value.fastStartTime
        }
    }
    
    private func setEatingRecordCardTime() {
        let isStartTimeZero = userDefaults.recordStartTime.timeIntervalSince1970 == 0
        let isEndTimeZero = userDefaults.recordEndTime.timeIntervalSince1970 == 0
        
        userDefaults.recordStartTime = recordStatus.value == .notSaved ? timerSetting.value.fastStartTime : findLastFastingSavedRecord().start
        userDefaults.recordEndTime = recordStatus.value == .notSaved ? timerSetting.value.fastEndTime : findLastFastingSavedRecord().end
        
        let startTimeFromTimer = timerSetting.value.fastStartTime.dateToSetTimeString()
        let startTimeFromUserDefaults = userDefaults.recordStartTime.dateToSetTimeString()
        
        let endTimeFromTimer = timerSetting.value.fastEndTime.dateToSetTimeString()
        let endTimeFromUserDefaults = userDefaults.recordEndTime.dateToSetTimeString()
        
        if recordStatus.value == .notSaved {
            recordCardTime.value.start = isStartTimeZero ? startTimeFromTimer : startTimeFromUserDefaults
            recordCardTime.value.end = isEndTimeZero ? endTimeFromTimer : endTimeFromUserDefaults
        } else {
            recordCardTime.value.start = startTimeFromUserDefaults
            recordCardTime.value.end = endTimeFromUserDefaults
        }
    }
    
    private func findLastFastingSavedRecord() -> (start: Date, end: Date) {
        guard let recordResults = recordResults else { return (Date(), Date()) }
        
        if let record = recordResults.first(where: { $0.fastingEndTime == userDefaults.recordEndTime }) {
            return (record.fastingStartTime, record.fastingEndTime)
            
        } else {
            return (Date(), Date())
        }
    }
    
    private func configRecordStatus() {
        guard let recordResults = recordResults else { return }
        let recordCardDateResult = recordResults.first(where: {
            $0.fastingEndTime == userDefaults.recordEndTime && $0.date.timeIntervalSince1970 > 0
        })
        
        recordStatus.value = recordCardDateResult == nil ? .notSaved : .saved
    }
    
    func configTimerSetting() {
        let isFastingEarly = userDefaults.isFastingEarly
        
        switch userDefaults.isPlanSetByUser {
        case true:
            let eatingStart = setEatingStartTimeWithDay()
            timerSetting.value.plan = userDefaults.fastPlanType
            timerSetting.value.fastStartTime = isFastingEarly ? userDefaults.recordStartTime : calculateFastStartTime(with: eatingStart)
            timerSetting.value.fastEndTime = eatingStart
            
        case false:
            let eatingStart = timerSetting.value.plan.defaultEatingStartTime
            timerSetting.value.plan = .sixteen
            timerSetting.value.fastStartTime = isFastingEarly ? userDefaults.recordStartTime : calculateFastStartTime(with: eatingStart)
            timerSetting.value.fastEndTime = eatingStart
            userDefaults.fastPlanType = .sixteen
            userDefaults.eatingStartTime = timerSetting.value.plan.defaultEatingStartTime
        }
        plusOneDayToFastStartTime()
    }
    
    private func setTimeForFastingEarly() {
        if userDefaults.isFastingEarly {
            timerSetting.value.fastStartTime = userDefaults.recordStartTime
        }
    }
    
    private func setEatingStartTimeWithDay() -> Date {
        let fastStartTime = calculateFastStartTime(with: userDefaults.eatingStartTime)
        let eatingStartTime = userDefaults.eatingStartTime
        
        if userDefaults.isFastingEarly {
            if Date() < eatingStartTime {
                return eatingStartTime
            } else {
                return Calendar.current.date(byAdding: .day, value: 1, to: eatingStartTime)!
            }
        } else {
            if Date() < fastStartTime {
                return Calendar.current.date(byAdding: .day, value: -1, to: eatingStartTime)!
            } else {
                return eatingStartTime
            }
        }
    }
    
    private func calculateFastStartTime(with eatingStartTime: Date) -> Date {
        let fastingHours = timerSetting.value.plan.rawValue
        
        return Calendar.current.date(byAdding: .hour, value: -fastingHours, to: eatingStartTime)!
    }
    
    private func calculateEatingEndTime() -> Date {
        let eatingStartTime = timerSetting.value.fastEndTime
        let eatingHour = 24 - timerSetting.value.plan.rawValue

        return Calendar.current.date(byAdding: .hour, value: eatingHour, to: eatingStartTime) ?? Date()
    }
    
    private func isPlusOneDayRequired() -> Bool {
        return Date() > userDefaults.eatingEndTime
    }
    
    private func plusOneDayToFastStartTime() {
        if isPlusOneDayRequired() {
            let fastingStartTime = timerSetting.value.fastStartTime
            timerSetting.value.fastStartTime = fastingStartTime.addOneDay()
        }
    }
    
    // MARK: - Timer
    
    func controlTimer() {
        switch fastState.value {
        case .idle:
            startTimer()
            fastState.value = .fasting
            userDefaults.isTimerRunning = true
            userDefaults.isFastingBreak = false
            userDefaults.isFastingEarly = false
            notification.setNotification()
            
        case .fasting, .fastingBreak, .fastingEarly:
            stopTimer()
            fastState.value = .idle
            userDefaults.isTimerRunning = false
            userDefaults.isFastingBreak = false
            userDefaults.isFastingEarly = false
            notification.removeNotification()
            configTimerSetting()
            configRecordCardTime()
            
        case .eating:
            stopTimer()
            fastState.value = .idle
            userDefaults.isTimerRunning = false
            notification.removeNotification()
            configTimerSetting()
            configRecordCardTime()
        }
    }
    
    private func configFastingCounter() {
        let remainingTime = Int(timerSetting.value.fastEndTime.timeIntervalSince(.now))
        setTimeCounter(remainingTime: remainingTime)
        
        if remainingTime <= 0 {
            timer = nil
        }
    }
    
    private func configEatingCounter() {
        let remainingTime = Int(calculateEatingEndTime().timeIntervalSince(.now))
        setTimeCounter(remainingTime: remainingTime)
        
        if remainingTime <= 0 {
            timer = nil
        }
    }
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
                self?.configTimerSetting()
                self?.configFastState()
                
                switch self?.fastState.value {
                case .fasting, .fastingBreak, .fastingEarly:
                    self?.configFastingCounter()
                    
                case .eating:
                    self?.configEatingCounter()
                    
                default:
                    break
                }
            })
        }
    }
    
    private func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            setTimeCounter(remainingTime: 0)
        }
    }
    
    private func setTimeCounter(remainingTime: Int) {
        let hour = remainingTime / 3600
        let minute = (remainingTime % 3600) / 60
        let second = (remainingTime % 3600) % 60
        
        timeCounter.value = String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    // MARK: - UserDefaults
    
    func saveEditedTimeToUserDefaults(type: EditTimeType, time: Date) {
        if type == .fastingStartedTime {
            userDefaults.recordStartTime = time
            recordCardTime.value.start = time.dateToSetTimeString()
            
        } else if type == .fastingEndedTime {
            userDefaults.recordEndTime = time
            recordCardTime.value.end = time.dateToSetTimeString()
        }
    }
    
    func configTimeViewEditable() {
        switch fastState.value {
        case .idle:
            isStartTimeEditable.value = false
            isEndTimeEditable.value = false
            
        case .fasting:
            isStartTimeEditable.value = true
            isEndTimeEditable.value = false
            
        case .eating:
            isStartTimeEditable.value = recordStatus.value == .notSaved ? true : false
            isEndTimeEditable.value = recordStatus.value == .notSaved ? true : false
            
        case .fastingBreak:
            isStartTimeEditable.value = true
            isEndTimeEditable.value = false
            
        case .fastingEarly:
            isStartTimeEditable.value = false
            isEndTimeEditable.value = false
        }
    }
    
    func makeTimerStartAlertMessage() -> String {
        let plan = userDefaults.fastPlanType.planButtonTitle
        let eatingStart = userDefaults.eatingStartTime.dateToTimeOnlyString()
        let eatingEnd = userDefaults.eatingEndTime.dateToTimeOnlyString()
        let message = Constants.Alert.TimerStart.message
        
        return "\(message)\n\(plan)\nEat from \(eatingStart) to \(eatingEnd)"
    }
    
    // MARK: - Realm
    
    private func fetchFastingRecord() {
        repository?.recordList = repository?.fetch()
        
        guard let results = recordResults else { return }
        recordList.value = Array(results)
    }
    
    func saveNewFastingRecord() throws {
        let record = makeFastingRecordTable()
        try repository?.create(record)
    }
    
    func updateTodaysRecord(isEarly: Bool) throws {
        guard let todayRecord = recordResults?.first(where: { $0.date.makeDateOnlyDate() == Date().makeDateOnlyDate() }) else { return }
        if isEarly {
            userDefaults.recordEndTime = Date()
            recordCardTime.value.end = Date().dateToSetTimeString()
        }
        
        let newRecord = makeFastingRecordTable()
        
        try repository?.updateRecord(id: todayRecord._id, record: newRecord)
    }
    
    private func makeFastingRecordTable() -> FastingRecordTable {
        let startTime = userDefaults.recordStartTime
        let endTime = userDefaults.recordEndTime
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: endTime)
        let date = Calendar.current.date(from: dateComponent)!
        
        let fastingPlan = userDefaults.fastPlanType.rawValue
        let fastingDuration = endTime.timeIntervalSince(startTime)
        
        let isGoalAchieved = fastingDuration / 3600 >= Double(fastingPlan) ? true : false
        
        let record = FastingRecordTable(date: date, fastingPlan: String(fastingPlan), fastingStartTime: startTime, fastingEndTime: endTime, fastingDuration: fastingDuration, isGoalAchieved: isGoalAchieved)
        
        return record
    }
    
    func checkIsNewRecordToday() -> FastingRecordTable? {
        if let record = recordResults?.first(where: { $0.date.makeDateOnlyDate() == Date().makeDateOnlyDate() }) {
            return record
        } else {
            return nil
        }
    }
    
    func makeTodaysRecordExistsAlertMessage(record: FastingRecordTable) -> String {
        let recordExists = Constants.Alert.TodaysRecordExists.recordExistsMessage
        let replace = Constants.Alert.TodaysRecordExists.replaceMessage
        let startTime = record.fastingStartTime.dateToSetTimeString()
        let endTime = record.fastingEndTime.dateToSetTimeString()
        
//        return "\(recordExists)\nFrom \(startTime) to \(endTime)\n\(replace)"
        return "existingRecord".localized(first: recordExists, second: startTime, third: endTime, fourth: replace)
    }
    
    // MARK: - Fasting Control
    
    func breakFasting() {
        let endTime = Date()
        userDefaults.recordEndTime = endTime
        recordCardTime.value.end = endTime.dateToSetTimeString()
        
        fastState.value = .fastingBreak
        userDefaults.isFastingBreak = true
    }
    
    func resumeFasting() {
        let endTime = timerSetting.value.fastEndTime
        userDefaults.recordEndTime = endTime
        recordCardTime.value.end = endTime.dateToSetTimeString()
        
        fastState.value = .fasting
        userDefaults.isFastingBreak = false
    }
    
    func startFastingEarly() {
        let startTime = Date()
        userDefaults.recordStartTime = startTime
        recordCardTime.value.start = startTime.dateToSetTimeString()
        
        fastState.value = .fastingEarly
        userDefaults.isFastingEarly = true
    }
}

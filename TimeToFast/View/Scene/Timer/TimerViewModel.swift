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
    var timerSetting = Observable(TimerSetting(plan: .sixteen, fastStartTime: Date()-3600*16, fastEndTime: Date(), eatingStartTime: Date(), eatingEndTime: Date()+3600*8))
    
    var fastState = Observable(FastState.idle)
    lazy var recordCardTime = Observable(RecordCardTime(
        startTime: timerSetting.value.fastStartTime,
        endTime: timerSetting.value.fastEndTime
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
        fetchFastingRecord()
        configTimerSetting()
        configFastState()
        configRecordCardTime()
        configTimeViewEditable()
        
        if fastState.value != .idle {
            startTimer()
        }
    }
    
    private func configFastState() {
        fastState.value = userDefaults.isTimerRunning ? fastingOrEating() : .idle
    }
    
    private func fastingOrEating() -> FastState {
        let current = Date()
        
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
            setIdleRecordCardTime()
        case .fasting, .fastingBreak, .fastingEarly:
            setFastingRecordCardTime()
        case .eating:
            setEatingRecordCardTime()
        }
    }
    
    private func setIdleRecordCardTime() {
        let startTimeFromTimer = timerSetting.value.fastStartTime
        let endTimeFromTimer = timerSetting.value.fastEndTime
        
        recordCardTime.value.startTime = startTimeFromTimer
        recordCardTime.value.endTime = endTimeFromTimer
    }
    
    private func setFastingRecordCardTime() {
        let isStartTimeZero = userDefaults.recordStartTime.timeIntervalSince1970 == 0
        let startTimeFromTimer = timerSetting.value.fastStartTime
        let startTimeFromUserDefaults = userDefaults.recordStartTime
        
        recordCardTime.value.startTime = isStartTimeZero ? startTimeFromTimer : startTimeFromUserDefaults
        
        if fastState.value == .fasting || fastState.value == .fastingEarly {
            recordCardTime.value.endTime = timerSetting.value.fastEndTime
            
        } else if fastState.value == .fastingBreak {
            recordCardTime.value.endTime = userDefaults.recordEndTime
        }
        
        if isStartTimeZero {
            userDefaults.recordStartTime = timerSetting.value.fastStartTime
        }
    }
    
    private func setEatingRecordCardTime() {
        let startTimeFromTimer = timerSetting.value.fastStartTime
        let endTimeFromTimer = timerSetting.value.fastEndTime
        
        let startTimeFromUserDefaults = userDefaults.recordStartTime
        let endTimeFromUserDefaults = userDefaults.recordEndTime
        let isStartTimeZero = startTimeFromUserDefaults.timeIntervalSince1970 == 0
        let isEndTimeZero = endTimeFromUserDefaults.timeIntervalSince1970 == 0
        
        let savedRecord = checkAndFindSavedRecord(with: endTimeFromUserDefaults)
        
        if let savedRecord {
            recordStatus.value = .saved
            recordCardTime.value.startTime = savedRecord.start
            recordCardTime.value.endTime = savedRecord.end
            
        } else {
            recordStatus.value = .notSaved
            recordCardTime.value.startTime = isStartTimeZero ? startTimeFromTimer : startTimeFromUserDefaults
            recordCardTime.value.endTime = isEndTimeZero ? endTimeFromTimer : endTimeFromUserDefaults
            
            if isStartTimeZero {
                userDefaults.recordStartTime = startTimeFromTimer
            }
            if isEndTimeZero {
                userDefaults.recordEndTime = endTimeFromTimer
            }
        }
    }
    
    private func checkAndFindSavedRecord(with date: Date) -> (start: Date, end: Date)? {
        guard let recordResults = recordResults else { return nil }
        
        if let record = recordResults.first(where: { $0.fastingEndTime == date }) {
            return (record.fastingStartTime, record.fastingEndTime)
        } else {
            return nil
        }
    }
    
    func configTimerSetting() {
        switch userDefaults.isPlanSetByUser {
        case false:
            configInitialTimerTimes()
            
        case true:
            let timerTimes = configTimerTimes()
            timerSetting.value.fastStartTime = timerTimes.fastStart
            timerSetting.value.fastEndTime = timerTimes.eatingStart
            timerSetting.value.eatingStartTime = timerTimes.eatingStart
            timerSetting.value.eatingEndTime = timerTimes.eatingEnd

        }
    }
    
    private func configInitialTimerTimes() {
        timerSetting.value.plan = .sixteen
        let defaultEatingStart = timerSetting.value.plan.defaultEatingStartTime
        timerSetting.value.fastStartTime = calculateFastStartTime(with: defaultEatingStart)
        timerSetting.value.fastEndTime = defaultEatingStart
        timerSetting.value.eatingStartTime = defaultEatingStart
        timerSetting.value.eatingEndTime = calculateEatingEndTime(with: defaultEatingStart)
        userDefaults.fastPlanType = .sixteen
        userDefaults.eatingStartTime = defaultEatingStart
    }
    
    private func configTimerTimes() -> (eatingStart: Date, eatingEnd: Date, fastStart: Date) {
        timerSetting.value.plan = userDefaults.fastPlanType
        
        var eatingStart = userDefaults.eatingStartTime
        var eatingEnd = userDefaults.eatingEndTime
        var fastStart = calculateFastStartTime(with: eatingStart)
        
        let current = Date()
        
        if current > eatingEnd {
            eatingStart = eatingStart.addOneDay()
            eatingEnd = eatingEnd.addOneDay()
            fastStart = fastStart.addOneDay()
        }
        
        if current < fastStart {
            eatingStart = eatingStart.minusOneDay()
            eatingEnd = eatingEnd.minusOneDay()
            fastStart = fastStart.minusOneDay()
        }
        
//        if userDefaults.isFastingEarly && current < eatingStart {
//
//        }
        
        return (eatingStart: eatingStart, eatingEnd: eatingEnd, fastStart: fastStart)
    }
    
//    private func setTimeForFastingEarly() {
//        if userDefaults.isFastingEarly {
//            timerSetting.value.fastStartTime = userDefaults.recordStartTime
//        }
//    }
    
//    private func setEatingStartTimeWithDay() -> Date {
//        let fastStartTime = calculateFastStartTime(with: userDefaults.eatingStartTime)
//        let eatingStartTime = userDefaults.eatingStartTime
//
//        if userDefaults.isFastingEarly {
//            if Date() < eatingStartTime {
//                return eatingStartTime
//            } else {
//                return Calendar.current.date(byAdding: .day, value: 1, to: eatingStartTime)!
//            }
//        } else {
//            if Date() < fastStartTime {
//                return Calendar.current.date(byAdding: .day, value: -1, to: eatingStartTime)!
//            } else {
//                return eatingStartTime
//            }
//        }
//    }
    
    private func calculateFastStartTime(with eatingStartTime: Date) -> Date {
        let fastingHours = timerSetting.value.plan.rawValue
        
        return Calendar.current.date(byAdding: .hour, value: -fastingHours, to: eatingStartTime)!
    }
    
    private func calculateEatingEndTime(with eatingStartTime: Date) -> Date {
        let eatingHour = 24 - timerSetting.value.plan.rawValue

        return Calendar.current.date(byAdding: .hour, value: eatingHour, to: eatingStartTime)!
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
        let remainingTime = Int(timerSetting.value.eatingEndTime.timeIntervalSince(.now))
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
            recordCardTime.value.startTime = time
            
        } else if type == .fastingEndedTime {
            userDefaults.recordEndTime = time
            recordCardTime.value.endTime = time
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
            recordCardTime.value.endTime = Date()
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
        
        return "existingRecord".localized(first: recordExists, second: startTime, third: endTime, fourth: replace)
    }
    
    // MARK: - Fasting Control
    
    func breakFasting() {
        let endTime = Date()
        userDefaults.recordEndTime = endTime
        recordCardTime.value.endTime = endTime
        
        fastState.value = .fastingBreak
        userDefaults.isFastingBreak = true
    }
    
    func resumeFasting() {
        let endTime = timerSetting.value.fastEndTime
        userDefaults.recordEndTime = endTime
        recordCardTime.value.endTime = endTime
        
        fastState.value = .fasting
        userDefaults.isFastingBreak = false
    }
    
    func startFastingEarly() {
        let startTime = Date()
        userDefaults.recordStartTime = startTime
        recordCardTime.value.startTime = startTime
        
        fastState.value = .fastingEarly
        userDefaults.isFastingEarly = true
    }
}

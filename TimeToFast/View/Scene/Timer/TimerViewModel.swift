//
//  TimerViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/04.
//

import Foundation

final class TimerViewModel {
    var stateTitle = Observable(Constants.StateTitle.idle)
    var timeCounter = Observable("00:00:00")
    var timerSetting = Observable(TimerSetting(plan: .sixteen, fastStartTime: Date()))
    var fastState = Observable(FastState.idle)
    lazy var recordCardTime = Observable(RecordCardTime(
        start: timerSetting.value.fastStartTime.dateToTimeOnlyString(),
        end: timerSetting.value.fastEndTime.dateToTimeOnlyString()
    ))
    
    var recordStatus = Observable(RecordStatus.notSaved)
    var isStartTimeEditable = Observable(false)
    var isEndTimeEditable = Observable(false)
    
    private var timer: Timer?
    
    private let userDefaults = UserDefaultsManager.shared
    private let repository = FastingRecordRepository.shared
    
    // MARK: - methods
    
    func getStoredSetting() {
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
        return current < timerSetting.value.fastEndTime ? .fasting : .eating
    }
    
    func configRecordCardTime() {
        switch fastState.value {
        case .idle:
            setIdleRecordCardTime()
        case .fasting:
            setFastingRecordCardTime()
        case .eating:
            setEatingRecordCardTime()
        }
    }
    
    private func setIdleRecordCardTime() {
        recordCardTime.value.start = timerSetting.value.fastStartTime.dateToTimeOnlyString()
        recordCardTime.value.end = timerSetting.value.fastEndTime.dateToTimeOnlyString()
    }
    
    private func setFastingRecordCardTime() {
        let isStartTimeZero = userDefaults.recordStartTime.timeIntervalSince1970 == 0
        let startTimeFromTimer = timerSetting.value.fastStartTime.dateToSetTimeString()
        let startTimeFromUserDefaults = userDefaults.recordStartTime.dateToSetTimeString()
        
        recordCardTime.value.start = isStartTimeZero ? startTimeFromTimer : startTimeFromUserDefaults
        recordCardTime.value.end = timerSetting.value.fastEndTime.dateToSetTimeString()
    }
    
    private func setEatingRecordCardTime() {
        let isStartTimeZero = userDefaults.recordStartTime.timeIntervalSince1970 == 0
        let startTimeFromTimer = timerSetting.value.fastStartTime.dateToSetTimeString()
        let startTimeFromUserDefaults = userDefaults.recordStartTime.dateToSetTimeString()
        
        
        let isEndTimeZero = userDefaults.recordEndTime.timeIntervalSince1970 == 0
        let endTimeFromTimer = timerSetting.value.fastEndTime.dateToSetTimeString()
        let endTimeFromUserDefaults = userDefaults.recordEndTime.dateToSetTimeString()
        
        recordCardTime.value.start = isStartTimeZero ? startTimeFromTimer : startTimeFromUserDefaults
        recordCardTime.value.end = isEndTimeZero ? endTimeFromTimer : endTimeFromUserDefaults
    }
    
    private func configTimerSetting() {
        switch userDefaults.isPlanSetByUser {
        case true:
            timerSetting.value.plan = userDefaults.fastPlanType
            timerSetting.value.fastStartTime = calculateFastStartTime(with: userDefaults.eatingStartTime)
            
        case false:
            timerSetting.value.plan = .sixteen
            timerSetting.value.fastStartTime = calculateFastStartTime(with: timerSetting.value.plan.defaultEatingStartTime)
        }
        plusOneDay()
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
    
    private func plusOneDay() {
        if Date() > userDefaults.eatingEndTime {
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
            
        case .fasting:
            stopTimer()
            fastState.value = .idle
            userDefaults.isTimerRunning = false
            
        case .eating:
            fastState.value = .idle
            userDefaults.isTimerRunning = false
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
                
                if self?.fastState.value == .fasting {
                    self?.configFastingCounter()
                    
                } else if self?.fastState.value == .eating {
                    self?.configEatingCounter()
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
        }
    }
    
    // MARK: - Realm
    
    func saveNewFastingRecord() throws {
        let record = makeFastingRecordTable()
        try repository?.create(record)
    }
    
    
    
    private func makeFastingRecordTable() -> FastingRecordTable {
        let startTime = userDefaults.recordStartTime
        let endTime = userDefaults.recordEndTime
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: endTime)
        let date = Calendar.current.date(from: dateComponent)!
        
        let fastingPlan = userDefaults.fastPlanType.rawValue
        let fastingDuration = endTime.timeIntervalSince(startTime)
        
        let isGoalAchieved = fastingDuration / 3600 > Double(fastingPlan) ? true : false
        
        let record = FastingRecordTable(date: date, fastingPlan: String(fastingPlan), fastingStartTime: startTime, fastingEndTime: endTime, fastingDuration: fastingDuration, isGoalAchieved: isGoalAchieved)
        
        return record
    }
}

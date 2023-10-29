//
//  TimerWidgetModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/29.
//

import Foundation

final class TimerWidgetModel: ObservableObject {
    @Published var fastState: FastState = .idle
    @Published var timeCounter: String = "00:00:00"
    @Published var targetDate: Date = Date()+3600*3
    
    @Published var fastingTrim: CGFloat = 0
    @Published var fastingRotation: CGFloat = 0
    
    @Published var eatingTrim: CGFloat = 0
    @Published var eatingRotation: CGFloat = 0
    
    @Published var timerSetting: TimerSetting = TimerSetting(
        plan: .sixteen,
        fastStartTime: .setTimeForToday(hour: 12, minute: 0)-3600*16,
        fastEndTime: .setTimeForToday(hour: 12, minute: 0),
        eatingStartTime: .setTimeForToday(hour: 12, minute: 0),
        eatingEndTime: .setTimeForToday(hour: 12, minute: 0)+3600*8
    )
    
    private let userDefaults = UserDefaultsManager.shared
    
    init() {
        fetchDataFromApp()
    }
    
    func fetchDataFromApp() {
        configTimerSetting()
        configFastState()
        configTargetDate()
    }
    
    // MARK: - TimerSetting
    
    private func configTimerSetting() {
        if !userDefaults.isPlanSetByUser {
            configInitialTimerTimes()
        }
        let timerTimes = configTimerTimes()
        timerSetting.fastStartTime = timerTimes.fastStart
        timerSetting.fastEndTime = timerTimes.eatingStart
        timerSetting.eatingStartTime = timerTimes.eatingStart
        timerSetting.eatingEndTime = timerTimes.eatingEnd
    }
    
    private func configInitialTimerTimes() {
        let defaultEatingStart = timerSetting.plan.defaultEatingStartTime
        
        userDefaults.fastPlanType = .sixteen
        userDefaults.eatingStartTime = defaultEatingStart
    }
    
    private func configTimerTimes() -> (eatingStart: Date, eatingEnd: Date, fastStart: Date) {
        timerSetting.plan = userDefaults.fastPlanType
        
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
        
        return (eatingStart: eatingStart, eatingEnd: eatingEnd, fastStart: fastStart)
    }
    
    private func calculateFastStartTime(with eatingStartTime: Date) -> Date {
        let fastingHours = timerSetting.plan.rawValue
        
        return Calendar.current.date(byAdding: .hour, value: -fastingHours, to: eatingStartTime)!
    }
    
    private func calculateEatingEndTime(with eatingStartTime: Date) -> Date {
        let eatingHour = 24 - timerSetting.plan.rawValue

        return Calendar.current.date(byAdding: .hour, value: eatingHour, to: eatingStartTime)!
    }
    
    // MARK: - fastState
    
    private func configFastState() {
        fastState = userDefaults.isTimerRunning ? fastingOrEating() : .idle
    }
    
    private func fastingOrEating() -> FastState {
        let current = Date()
        
        let fastStartTime = timerSetting.fastStartTime
        let fastEndTime = timerSetting.fastEndTime
        
        if fastStartTime < current && current < fastEndTime {
            if userDefaults.isFastingBreak {
                return .fastingBreak
            } else if userDefaults.isFastingEarly {
                return .fastingEarly
            } else {
                return .fasting
            }
        } else {
            userDefaults.isFastingBreak = false
            userDefaults.isFastingEarly = false
            return .eating
        }
    }
    
    private func configTargetDate() {
        
    }
    
    // MARK: - TimerGauge
    
    
}

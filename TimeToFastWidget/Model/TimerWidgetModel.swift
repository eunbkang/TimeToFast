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
    
    @Published var timerSetting: TimerSetting = TimerSetting(
        plan: .sixteen,
        fastStartTime: .setTimeForToday(hour: 12, minute: 0)-3600*16,
        fastEndTime: .setTimeForToday(hour: 12, minute: 0),
        eatingStartTime: .setTimeForToday(hour: 12, minute: 0),
        eatingEndTime: .setTimeForToday(hour: 12, minute: 0)+3600*8
    )
    
    @Published var fastingTrackTrim: CGFloat = 0.7
    @Published var fastingTrackRotation: CGFloat = -155.0
    
    @Published var eatingTrackTrim: CGFloat = 0.32
    @Published var eatingTrackRotation: CGFloat = 90
    
    @Published var fastingProgressTrim: CGFloat = 0.4
    @Published var fastingProgressRotation: CGFloat = -155.0
    
    @Published var eatingProgressTrim: CGFloat = 0.2
    @Published var eatingProgressRotation: CGFloat = 90
    
    @Published var isFastingProgressVisible: Bool = false
    @Published var isEatingProgressVisible: Bool = false
    
    private let userDefaults = UserDefaultsManager.shared
    
    private var timer: Timer?
    
    var configDate: Date {
        didSet {
            fetchDataFromApp()
        }
    }
    
    init(configDate: Date) {
        self.configDate = configDate
        fetchDataFromApp()
    }
    
    func fetchDataFromApp() {
        configTimerSetting()
        configFastState()
        setTimerGaugeAngle()
        configProgressGaugeVisible()
//        controlTimer()
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
        
        let current = configDate
        
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
        let current = configDate
        
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
    
    // MARK: - TimerGauge
    
    func setTimerGaugeAngle() {
        let fastAngle = calculateAngle(start: timerSetting.fastStartTime, end: timerSetting.fastEndTime)
        fastingTrackTrim = fastAngle.trim
        fastingTrackRotation = fastAngle.rotation
        
        let eatingAngle = calculateAngle(start: timerSetting.eatingStartTime, end: timerSetting.eatingEndTime)
        eatingTrackTrim = eatingAngle.trim
        eatingTrackRotation = eatingAngle.rotation
        
        fastingProgressTrim = calculateAngle(start: timerSetting.fastStartTime, end: configDate).trim
        fastingProgressRotation = fastAngle.rotation
        
        eatingProgressTrim = calculateAngle(start: timerSetting.eatingStartTime, end: configDate).trim
        eatingProgressRotation = eatingAngle.rotation
    }
    
    private func calculateAngle(start: Date, end: Date) -> (trim: CGFloat, rotation: CGFloat) {
        let timeInterval = end.timeIntervalSince(start)
        let perTenMinutes: CGFloat = 1 / (6*24)
        let trim = perTenMinutes * timeInterval / (10*60)
        
        let rotation = start.dateToAngleDegree()
        
        return (trim, rotation)
    }
    
    private func configProgressGaugeVisible() {
        switch fastState {
        case .idle:
            isFastingProgressVisible = false
            isEatingProgressVisible = false
        case .fasting, .fastingBreak, .fastingEarly:
            isFastingProgressVisible = true
            isEatingProgressVisible = false
        case .eating:
            isFastingProgressVisible = true
            isEatingProgressVisible = true
        }
    }
    
    private func controlTimer() {
        if fastState == .idle {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        } else {
            if timer == nil {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
                    self?.setTimerGaugeAngle()
                })
            }
        }
    }
}

//
//  TimerViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/04.
//

import Foundation

final class TimerViewModel {
    var stateTitle = Observable(Constants.StateTitle.idle)
    var timeCounter = Observable("")
    var timerSetting = Observable(TimerSetting(plan: .sixteen, fastStartTime: Date()-60*60*10))
    var fastState = Observable(FastState.idle)
    
    private var timer: Timer?
    
    private let userDefaults = UserDefaultsManager.shared
    
    func getStoredSetting() {
        fastState.value = userDefaults.isTimerRunning ? .fasting : .idle
        if fastState.value != .idle {
            startTimer()
        }
        
        switch userDefaults.isPlanSetByUser {
        case true:
            timerSetting.value.plan = userDefaults.fastPlanType ?? .sixteen
            timerSetting.value.fastStartTime = calculateFastStartTime(with: userDefaults.eatingStartTime)
            
        case false:
            timerSetting.value.plan = .sixteen
            timerSetting.value.fastStartTime = calculateFastStartTime(with: timerSetting.value.plan.defaultEatingStartTime)
        }
    }
    
    private func calculateFastStartTime(with eatingStartTime: Date) -> Date {
        let fastingHours = timerSetting.value.plan.rawValue
        
        return Calendar.current.date(byAdding: .hour, value: -fastingHours, to: eatingStartTime)!
    }
    
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
    
    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
                let remainingTime = Int(self?.timerSetting.value.fastEndTime?.timeIntervalSince(.now) ?? 0)
                self?.setTimeCounter(remainingTime: remainingTime)
                
                if remainingTime <= 0 {
                    self?.timer = nil
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
}

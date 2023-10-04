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
    var timerSetting = Observable(TimerSetting(fastStartTime: Date()))
    var fastState = Observable(FastState.idle)
    
    private var timer: Timer?
    
    func controlTimer() {
        switch fastState.value {
        case .idle:
            startTimer()
            fastState.value = .fasting
            
        case .fasting:
            fastState.value = .idle
            
        case .eating:
            fastState.value = .idle
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
    
    private func setTimeCounter(remainingTime: Int) {
        let hour = remainingTime / 3600
        let minute = (remainingTime % 3600) / 60
        let second = (remainingTime % 3600) % 60
        
        timeCounter.value = String(format: "%02d:%02d:%02d", hour, minute, second)
        print(timeCounter.value)
    }
}

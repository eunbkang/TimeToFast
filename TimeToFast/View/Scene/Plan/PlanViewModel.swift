//
//  PlanViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import Foundation

final class PlanViewModel {
    
    var planSetting = Observable(PlanSetting(plan: .sixteen, eatingStartTime: Date()-60*60*2))
    
    private let userDefaults = UserDefaultsManager.shared
    
    private let notification = NotificationManager.shared
    
    func savePlan() {
        userDefaults.isPlanSetByUser = true
        userDefaults.fastPlanType = planSetting.value.plan
        userDefaults.eatingStartTime = planSetting.value.eatingStartTime
        userDefaults.recordStartTime = Date(timeIntervalSince1970: 0)
        userDefaults.recordEndTime = Date(timeIntervalSince1970: 0)
        
        notification.setNotification()
    }
    
    func getStoredSetting() {
        switch userDefaults.isPlanSetByUser {
        case true:
            planSetting.value.plan = userDefaults.fastPlanType ?? .sixteen
            planSetting.value.eatingStartTime = userDefaults.eatingStartTime
            
        case false:
            planSetting.value.plan = .sixteen
            planSetting.value.eatingStartTime = planSetting.value.plan.defaultEatingStartTime
        }
    }
}

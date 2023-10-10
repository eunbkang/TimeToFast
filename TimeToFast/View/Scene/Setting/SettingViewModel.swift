//
//  SettingViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/10.
//

import Foundation

final class SettingViewModel {
    
    var isNotificationOn = Observable(true)
    
    private let userDefaults = UserDefaultsManager.shared
    
    func getStoredSetting() {
        isNotificationOn.value = userDefaults.isNotificationOn
    }
    
    func saveToggleSwitchValue(index: Int, isOn: Bool) {
        if Setting.allCases[index] == .notification {
            userDefaults.isNotificationOn = isOn
        }
    }
    
    func configToggleSwitchIsOn(index: Int) -> Bool {
        if Setting.allCases[index] == .notification {
            return isNotificationOn.value
        } else {
            return false
        }
    }
}

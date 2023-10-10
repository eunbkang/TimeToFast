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
    
    func saveNotificationSetting() {
//        userDefaults.isNotificationOn =
    }
    
}

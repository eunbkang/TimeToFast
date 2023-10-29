//
//  UserDefaults+Extension.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/29.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupID = "group.devRain.TimeToFast"
        
        return UserDefaults(suiteName: appGroupID)!
    }
}

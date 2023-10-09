//
//  PlanSetting.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import Foundation

struct PlanSetting {
    var eatingStartTime: Date
    var eatingEndTime: Date? {
        return Calendar.current.date(byAdding: .hour, value: 8, to: eatingStartTime)
    }
}

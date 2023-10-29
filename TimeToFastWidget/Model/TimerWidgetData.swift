//
//  TimerWidgetData.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/29.
//

import Foundation

struct TimerWidgetData {
    var state: FastState
    var timeCounter: String
    var targetDate: Date
    
    var fastingTrim: CGFloat
    var fastingRotation: CGFloat
    
    var eatingTrim: CGFloat
    var eatingRotation: CGFloat
}

extension TimerWidgetData {
    static let previewData = TimerWidgetData(state: .fasting, timeCounter: "00:00", targetDate: Date()+3600*2, fastingTrim: 0.7, fastingRotation: -155.0, eatingTrim: 0.32, eatingRotation: 90)
}

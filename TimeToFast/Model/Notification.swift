//
//  Notification.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/12.
//

import Foundation

struct LocalNotification {
    let title: String
    let body: String
}

struct NotificationMessage {
    var fastingStart = LocalNotification(title: "Time to fast!", body: "Fasting time has started. Stay committed!")
    var eatingStart = LocalNotification(title: "Time to eat!", body: "It's time to eat! Break your fast with a healthy meal.")
}

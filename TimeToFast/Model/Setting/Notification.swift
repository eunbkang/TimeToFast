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
    var fastingStart = LocalNotification(title: Localizing.Notification.fastingStartTitle, body: Localizing.Notification.fastingStartBody)
    var eatingStart = LocalNotification(title: Localizing.Notification.eatingStartTitle, body: Localizing.Notification.eatingStartBody)
}

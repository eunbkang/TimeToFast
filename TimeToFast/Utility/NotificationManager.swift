//
//  NotificationManager.swift
//  TimeToFast 
//
//  Created by Eunbee Kang on 2023/10/12.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() { }
    
    private let userDefaults = UserDefaultsManager.shared
    
    var notificationMessage = NotificationMessage()
    
    private func makeEatingStartDateComponent() -> DateComponents {
        let eatingStartTime = userDefaults.eatingStartTime
        
        return Calendar.current.dateComponents([.hour, .minute], from: eatingStartTime)
    }
    
    private func makeFastingStartDateComponent() -> DateComponents {
        let eatingEndTime = userDefaults.eatingEndTime
        
        return Calendar.current.dateComponents([.hour, .minute], from: eatingEndTime)
    }
    
    private func sendFastingNotification() {
        let message = notificationMessage.fastingStart
        
        let content = UNMutableNotificationContent()
        content.title = message.title
        content.body = message.body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: makeFastingStartDateComponent(), repeats: true)
        let request = UNNotificationRequest(identifier: Constants.Notification.fastingStartIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    private func sendEatingNotification() {
        let message = notificationMessage.eatingStart
        
        let content = UNMutableNotificationContent()
        content.title = message.title
        content.body = message.body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: makeEatingStartDateComponent(), repeats: true)
        let request = UNNotificationRequest(identifier: Constants.Notification.eatingStartIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    private func createNotification() {
        sendFastingNotification()
        sendEatingNotification()
    }
    
    private func removeNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func setNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                switch self.userDefaults.isNotificationOn {
                case true:
                    self.createNotification()
                case false:
                    self.removeNotification()
                }
            default:
                self.removeNotification()
            }
        }
    }
}

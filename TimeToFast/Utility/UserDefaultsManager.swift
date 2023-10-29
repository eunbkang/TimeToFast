//
//  UserDefaultsManager.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    let userDefaults = UserDefaults.standard
    let sharedUserDefaults = UserDefaults.shared
    
    // MARK: - States
    
    var isTimerRunning: Bool {
        get {
            return sharedUserDefaults.bool(forKey: Constants.Keys.isTimerRunning)
        }
        set {
            sharedUserDefaults.set(newValue, forKey: Constants.Keys.isTimerRunning)
        }
    }
    
    var isFastingBreak: Bool {
        get {
            return sharedUserDefaults.bool(forKey: Constants.Keys.isFastingBreak)
        }
        set {
            sharedUserDefaults.set(newValue, forKey: Constants.Keys.isFastingBreak)
        }
    }
    
    var isFastingEarly: Bool {
        get {
            return sharedUserDefaults.bool(forKey: Constants.Keys.isFastingEarly)
        }
        set {
            sharedUserDefaults.set(newValue, forKey: Constants.Keys.isFastingEarly)
        }
    }
    
    // MARK: - Plan
    
    var isPlanSetByUser: Bool {
        get {
            return sharedUserDefaults.bool(forKey: Constants.Keys.isPlanSetByUser)
        }
        set {
            sharedUserDefaults.set(newValue, forKey: Constants.Keys.isPlanSetByUser)
        }
    }
    
    var fastPlanType: FastingPlan {
        get {
            let fastingHour = sharedUserDefaults.integer(forKey: Constants.Keys.fastPlanType)
            let type = FastingPlan.allCases.first(where: { $0.rawValue == fastingHour }) ?? .sixteen
            return type
        }
        set {
            sharedUserDefaults.set(newValue.rawValue, forKey: Constants.Keys.fastPlanType)
        }
    }
    
    var eatingStartTime: Date {
        get {
            return .setTimeForToday(hour: eatingStartHour, minute: eatingStartMinute)
        }
        set {
            guard let hour = Int(newValue.dateToTimeHour()) else { return }
            guard let minute = Int(newValue.dateToTimeMinute()) else { return }
            eatingStartHour = hour
            eatingStartMinute = minute
        }
    }
    
    var eatingEndTime: Date {
        let eatingHour = fastPlanType.eatingHours
        
        return Calendar.current.date(byAdding: .hour, value: eatingHour, to: eatingStartTime)!
    }
    
    private var eatingStartHour: Int {
        get {
            return sharedUserDefaults.integer(forKey: Constants.Keys.eatingStartHour)
        }
        set {
            sharedUserDefaults.set(newValue, forKey: Constants.Keys.eatingStartHour)
        }
    }
    
    private var eatingStartMinute: Int {
        get {
            return sharedUserDefaults.integer(forKey: Constants.Keys.eatingStartMinute)
        }
        set {
            sharedUserDefaults.set(newValue, forKey: Constants.Keys.eatingStartMinute)
        }
    }
    
    // MARK: - RecordCardTime
    
    var recordStartTime: Date {
        get {
            return Date(timeIntervalSince1970: userDefaults.double(forKey: Constants.Keys.recordStartTime))
        }
        set {
            userDefaults.set(newValue.timeIntervalSince1970, forKey: Constants.Keys.recordStartTime)
        }
    }
    
    var recordEndTime: Date {
        get {
            return Date(timeIntervalSince1970: userDefaults.double(forKey: Constants.Keys.recordEndTime))
        }
        set {
            userDefaults.set(newValue.timeIntervalSince1970, forKey: Constants.Keys.recordEndTime)
        }
    }
    
    var lastEatingEndTime: Date {
        get {
            return Date(timeIntervalSince1970: userDefaults.double(forKey: Constants.Keys.lastEatingEndTime))
        }
        set {
            userDefaults.set(newValue.timeIntervalSince1970, forKey: Constants.Keys.lastEatingEndTime)
        }
    }
    
    // MARK: - Setting
    
    var isNotificationOn: Bool {
        get {
            return userDefaults.bool(forKey: Constants.Keys.isNotificationOn)
        }
        set {
            userDefaults.set(newValue, forKey: Constants.Keys.isNotificationOn)
        }
    }
}

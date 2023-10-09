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
    
    var isTimerRunning: Bool {
        get {
            return userDefaults.bool(forKey: Constants.Keys.isTimerRunning)
        }
        set {
            userDefaults.set(newValue, forKey: Constants.Keys.isTimerRunning)
        }
    }
    
    var fastPlanType: FastingPlan? {
        get {
            let fastingHour = userDefaults.integer(forKey: Constants.Keys.fastPlanType)
            let type = FastingPlan.allCases.first(where: { $0.rawValue == fastingHour })
            return type
        }
        set {
            guard let newValue = newValue else { return }
            userDefaults.set(newValue.rawValue, forKey: Constants.Keys.fastPlanType)
        }
    }
    
    var eatingStartTime: Date? {
        get {
            var components = DateComponents()
            components.hour = eatingStartHour
            components.minute = eatingStartMinute
            
            return Calendar.current.date(from: components)
        }
        set {
            guard let newValue = newValue else { return }
            guard let hour = Int(newValue.dateToTimeHour()) else { return }
            guard let minute = Int(newValue.dateToTimeMinute()) else { return }
            eatingStartHour = hour
            eatingStartMinute = minute
        }
    }
    
    private var eatingStartHour: Int {
        get {
            return userDefaults.integer(forKey: Constants.Keys.eatingStartHour)
        }
        set {
            userDefaults.set(newValue, forKey: Constants.Keys.eatingStartHour)
        }
    }
    
    private var eatingStartMinute: Int {
        get {
            return userDefaults.integer(forKey: Constants.Keys.eatingStartMinute)
        }
        set {
            userDefaults.set(newValue, forKey: Constants.Keys.eatingStartMinute)
        }
    }
}

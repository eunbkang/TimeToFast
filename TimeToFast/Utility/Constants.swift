//
//  Constants.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit

enum Constants {
    
    enum FastPlan {
        static let fast1410 = "14:10"
        static let fast1608 = "16:8"
        static let fast1806 = "18:6"
        static let fast2004 = "20:4"
    }
    
    enum TimerControl {
        static let playing = ""
        static let stopped = "START TIMER"
        
        static let playingImage = "stop.fill"
        static let stoppedImage = "play.fill"
    }
    
    enum FastControl {
        static let start = "START FAST EARLY"
        static let end = "END FAST EARLY"
    }
    
    enum StateTitle {
        static let idle = "It's time to fast!"
        static let fasting = "You're fasting!"
        static let eating = "You're eating!"
    }
    
    enum TimeStatus {
        static let eating = "FASTING STARTS IN"
        static let base = "REMAINING TIME"
    }
    
    enum SetTimeTitle {
        static let started = "STARTED"
        static let goal = "GOAL"
    }
    
    enum Size {
        static let edgePadding: CGFloat = 16
        static let buttonCorner: CGFloat = 12
        static let backgroundCorner: CGFloat = 16
        
        static let timer: CGFloat = 0.78
        static let timerRadius: CGFloat = 0.4625
        
        enum FastingCircle {
            static let width: CGFloat = 58
            static let line: CGFloat = 9
        }
    }
    
    enum Color {
        static let mainPurple = UIColor(hex: "8C02E0")!
        static let lightPurple = UIColor(hex: "E2BDF9")!
        static let darkPurple = UIColor(hex: "8C02E0")!
        
        static let mainGreen = UIColor(hex: "A6E002")!
        static let lightGreen = UIColor(hex: "E8F9B8")!
        static let darkGreen = UIColor(hex: "83B000")!
        
        static let veryLightGray = UIColor(hex: "F5F5F5")!
        static let darkGray = UIColor(hex: "787878")!
    }
    
    enum Keys {
        static let isTimerRunning = "isTimerRunning"
        static let isPlanSetByUser = "isPlanSetByUser"
        
        static let fastPlanType = "fastPlanType"
        static let eatingStartHour = "eatingStartHour"
        static let eatingStartMinute = "eatingStartMinute"
        
        static let isNotificationOn = "isNotificationOn"
        
        static let recordStartTime = "recordStartTime"
        static let recordEndTime = "recordEndTime"
    }
    
    enum Notification {
        static let fastingStartIdentifier = "fastingStartNotification"
        static let eatingStartIdentifier = "eatingStartNotification"
    }
    
    enum Alert {
        enum EditPlan {
            static let title = "Edit Plan"
            static let message = "Editing plan will reset the timer and any unsaved fasting results."
        }
        
        enum SaveRecord {
            static let title = "Save"
            static let message = "Do you want to save your last fasting result?"
        }
        
        enum TodaysRecordExists {
            static let title = "Today's record exists"
            static let message = "You have saved today's fasting result already. Do you want to replace it with the new data?"
        }
        
        enum SaveSucceed {
            static let title = "Saved Successfully."
        }
        
        enum SaveError {
            static let title = "Error"
            static let message = "Failed to save the record."
        }
        
        enum TimerStart {
            static let title = "Start Timer"
            static let message = "Do you want to start the fasting timer with this plan?"
        }
        
        enum TimerStop {
            static let title = "Stop Timer"
            static let message = "Do you really want to stop the fasting timer?"
        }
    }
}

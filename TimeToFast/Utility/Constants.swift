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
        static let playing = Localizing.Control.stopTimer
        static let stopped = Localizing.Control.playTimer
        
        static let playingImage = "stop.fill"
        static let stoppedImage = "play.fill"
    }
    
    enum FastControl {
        static let startEarly = Localizing.Control.startFastEarly
        static let breakFast = Localizing.Control.breakFast
        static let resumeFast = Localizing.Control.resumeFast
    }
    
    enum StateTitle {
        static let idle = Localizing.State.idle
        static let fasting = Localizing.State.fasting
        static let eating = Localizing.State.eating
        static let breakFast = Localizing.State.breakingFast
    }
    
    enum TimeStatus {
        static let eating = Localizing.State.fastingStartsIn
        static let base = Localizing.State.remainingTime
    }
    
    enum SetTimeTitle {
        static let started = Localizing.Time.started
        static let goal = Localizing.Time.goal
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
        static let isFastingBreak = "isFastingBreak"
        static let isFastingEarly = "isFastingEarly"
        
        static let fastPlanType = "fastPlanType"
        static let eatingStartHour = "eatingStartHour"
        static let eatingStartMinute = "eatingStartMinute"
        static let eatingStartTime = "eatingStartTime"
        
        static let isNotificationOn = "isNotificationOn"
        
        static let recordStartTime = "recordStartTime"
        static let recordEndTime = "recordEndTime"
        
        static let eatingStartWhenFastedEarly = "eatingStartWhenFastedEarly"
    }
    
    enum Notification {
        static let fastingStartIdentifier = "fastingStartNotification"
        static let eatingStartIdentifier = "eatingStartNotification"
    }
    
    enum Alert {
        enum EditPlan {
            static let title = Localizing.Alert.editPlanTitle
            static let message = Localizing.Alert.editPlanMessage
        }
        
        enum SaveRecord {
            static let title = Localizing.Alert.saveRecordTitle
            static let message = Localizing.Alert.saveRecordMessage
        }
        
        enum TodaysRecordExists {
            static let title = Localizing.Alert.todayRecordExistsTitle
            static let recordExistsMessage = Localizing.Alert.todayRecordExistsMessage
            static let replaceMessage = Localizing.Alert.todayRecordReplaceMessage
        }
        
        enum SaveSucceed {
            static let title = Localizing.Alert.saveSucceedTitle
        }
        
        enum SaveError {
            static let title = Localizing.Alert.saveErrorTitle
            static let message = Localizing.Alert.saveErrorMessage
        }
        
        enum TimerStart {
            static let title = Localizing.Alert.timerStartTitle
            static let message = Localizing.Alert.timerStartMessage
        }
        
        enum TimerStop {
            static let title = Localizing.Alert.timerStopTitle
            static let message = Localizing.Alert.timerStopMessage
        }
        
        enum StartEarly {
            static let title = Localizing.Alert.startEarlyTitle
            static let message = Localizing.Alert.startEarlyMessage
        }
        
        enum BreakFast {
            static let title = Localizing.Alert.breakFastTitle
            static let message = Localizing.Alert.breakFastMessage
        }
        
        enum ResumeFast {
            static let title = Localizing.Alert.resumeFastTitle
            static let message = Localizing.Alert.resumeFastMessage
        }
    }
}

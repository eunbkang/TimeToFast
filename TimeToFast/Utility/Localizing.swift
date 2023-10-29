//
//  Localizing.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/22.
//

import Foundation

struct Localizing {
    struct Title {
        static let editPlan = "editPlan".localized
        static let records = "records".localized
        static let settings = "settings".localized
        static let fastingPlanTitle = "fastingPlanTitle".localized
    }
    
    struct Plan {
        static let planButtonTitle = "planButtonTitle".localized
        static let planDetail = "planDetail".localized
    }
    
    struct Control {
        static let playTimer = "playTimer".localized
        static let stopTimer = "stopTimer".localized
        
        static let startFastEarly = "startFastEarly".localized
        static let breakFast = "breakFast".localized
        static let resumeFast = "resumeFast".localized
    }
    
    struct State {
        static let idle = "idle".localized
        static let fasting = "fasting".localized
        static let eating = "eating".localized
        static let breakingFast = "breakingFast".localized
        
        static let widgetIdle = "widgetIdle".localized
        static let widgetFasting = "widgetFasting".localized
        static let widgetEating = "widgetEating".localized
        static let widgetFastingBreak = "widgetFastingBreak".localized
        
        static let fastingStartsIn = "fastingStartsIn".localized
        static let remainingTime = "remainingTime".localized
        
        static let widgetRemaining = "widgetRemaining".localized
    }
    
    struct Time {
        static let starts = "starts".localized
        static let ends = "ends".localized
        static let started = "started".localized
        static let goal = "goal".localized
        static let ended = "ended".localized
        
        static let from = "from".localized
        static let to = "to".localized
    }
    
    struct EditTime {
        static let editStartedTime = "editStartedTime".localized
        static let editEndedTime = "editEndedTime".localized
        static let eatingFrom = "eatingFrom".localized
    }
    
    struct Button {
        static let save = "save".localized
        static let saveUpper = "saveUpper".localized
        static let savedUpper = "savedUpper".localized
    }
    
    struct Header {
        static let weeklySchedule = "weeklySchedule".localized
        static let fastingPlan = "fastingPlan".localized
        static let eatingPeriod = "eatingPeriod".localized
        static let fastingInProgress = "fastingInProgress".localized
        static let lastFastingResult = "lastFastingResult".localized
        static let thisWeek = "thisWeek".localized
        static let pastRecords = "pastRecords".localized
    }
    
    struct Days {
        static let mon = "mon".localized
        static let tue = "tue".localized
        static let wed = "wed".localized
        static let thu = "thu".localized
        static let fri = "fri".localized
        static let sat = "sat".localized
        static let sun = "sun".localized
    }
    
    struct Setting {
        static let notification = "notification".localized
    }
    
    struct Alert {
        static let yes = "yes".localized
        static let cancel = "cancel".localized
        static let replace = "replace".localized
        static let ok = "ok".localized
        static let confirm = "confirm".localized
        
        static let editPlanTitle = "editPlanTitle".localized
        static let editPlanMessage = "editPlanMessage".localized
        
        static let saveRecordTitle = "saveRecordTitle".localized
        static let saveRecordMessage = "saveRecordMessage".localized
        
        static let todayRecordExistsTitle = "todayRecordExistsTitle".localized
        static let todayRecordExistsMessage = "todayRecordExistsMessage".localized
        static let todayRecordReplaceMessage = "todayRecordReplaceMessage".localized
        static let existingRecord = "existingRecord".localized
        
        static let saveSucceedTitle = "saveSucceedTitle".localized
        
        static let saveErrorTitle = "saveErrorTitle".localized
        static let saveErrorMessage = "saveErrorMessage".localized
        
        static let timerStartTitle = "timerStartTitle".localized
        static let timerStartMessage = "timerStartMessage".localized
        
        static let timerStopTitle = "timerStopTitle".localized
        static let timerStopMessage = "timerStopMessage".localized
        
        static let startEarlyTitle = "startEarlyTitle".localized
        static let startEarlyMessage = "startEarlyMessage".localized
        
        static let breakFastTitle = "breakFastTitle".localized
        static let breakFastMessage = "breakFastMessage".localized
        
        static let resumeFastTitle = "resumeFastTitle".localized
        static let resumeFastMessage = "resumeFastMessage".localized
    }
    
    struct Record {
        static let noChartData = "noChartData".localized
        static let noRecord = "noRecord".localized
        static let goalAchieved = "goalAchieved".localized
        static let hours = "hours".localized
    }
    
    struct Notification {
        static let fastingStartTitle = "fastingStartTitle".localized
        static let fastingStartBody = "fastingStartBody".localized
        
        static let eatingStartTitle = "eatingStartTitle".localized
        static let eatingStartBody = "eatingStartBody".localized
    }
}

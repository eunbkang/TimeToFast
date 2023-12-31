//
//  Timer.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/28.
//

import Foundation

struct TimerSetting {
    var plan: FastingPlan
    
    var fastStartTime: Date
    var fastEndTime: Date
//    var fastEndTime: Date {
//        return Calendar.current.date(byAdding: .hour, value: plan.rawValue, to: fastStartTime)!
//    }
    
    var fastStartAngle: CGFloat {
        return fastStartTime.dateToAngle()
    }
    
    var fastEndAngle: CGFloat {
        return fastEndTime.dateToAngle()
    }
    
    var eatingStartTime: Date
    var eatingEndTime: Date
    
    var eatingStartAngle: CGFloat {
        return eatingStartTime.dateToAngle()
    }
    
    var eatingEndAngle: CGFloat {
        return eatingEndTime.dateToAngle()
    }
} 

//
//  Timer.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/28.
//

import Foundation

struct Timer {
    var fastStartTime: Date
    var fastEndTime: Date
    
    var fastStartAngle: CGFloat {
        return dateToAngle(date: fastStartTime)
    }
    
    var fastEndAngle: CGFloat {
        return dateToAngle(date: fastEndTime)
    }
    
    func dateToAngle(date: Date) -> CGFloat {
        let hours = CGFloat(date.hours)
        let minutes = CGFloat(date.minutes)
        
        let hourAngle = ((hours - 6) * 360/24).degreeToRadian
        let minuteAngle = (minutes * 360/(60*24)).degreeToRadian
        
        return hourAngle + minuteAngle
    }
}

//
//  Timer.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/28.
//

import Foundation

struct TimerSetting {
    var fastStartTime: Date
    var fastEndTime: Date? {
        return Calendar.current.date(byAdding: .hour, value: 16, to: fastStartTime)
    }
    
    var fastStartAngle: CGFloat {
        return dateToAngle(date: fastStartTime)
    }
    
    var fastEndAngle: CGFloat {
        guard let angle = fastEndTime else { return 0 }
        return dateToAngle(date: angle)
    }
    
    func dateToAngle(date: Date) -> CGFloat {
        let hours = CGFloat(date.hours)
        let minutes = CGFloat(date.minutes)
        
        let hourAngle = ((hours - 6) * 360/24).degreeToRadian
        let minuteAngle = (minutes * 360/(60*24)).degreeToRadian
        
        return hourAngle + minuteAngle
    }
}

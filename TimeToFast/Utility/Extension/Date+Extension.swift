//
//  Date+Extension.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import Foundation

extension Date {
    func dateToAngle() -> CGFloat {
        let hours = CGFloat(self.hours)
        let minutes = CGFloat(self.minutes)
        
        let hourAngle = ((hours - 6) * 360/24).degreeToRadian
        let minuteAngle = (minutes * 360/(60*24)).degreeToRadian
        
        return hourAngle + minuteAngle
    }
    
    func dateToSetTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateToTimeOnlyString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeStyle = .short
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateToTimeHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateToTimeMinute() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "m"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

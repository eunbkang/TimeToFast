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
//        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.dateStyle = .short
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
    
    func addOneDay() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    static func setTimeForToday(hour: Int = 0, minute: Int = 0) -> Date {
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let today = calendar.date(from: todayComponents)!
        let hourReflectedDate = calendar.date(byAdding: .hour, value: hour, to: today)!
        let calculatedDate = calendar.date(byAdding: .minute, value: minute, to: hourReflectedDate)!
        
        return calculatedDate
    }
}

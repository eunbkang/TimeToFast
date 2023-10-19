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
        let angle = (hours + minutes/60) * 360/24
        
        return angle.degreeToRadian - .pi/2
    }
    
    func dateToSetTimeString() -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateToFullTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        
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
    
    func dateToWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func yearAndMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func addOneDay() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let today = calendar.date(from: todayComponents)!
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let thisDate = calendar.date(from: dateComponents)!
        
        return today == thisDate ? true : false
    }
    
    func makeDateOnlyDate() -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        return calendar.date(from: dateComponents)!
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

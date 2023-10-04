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
}

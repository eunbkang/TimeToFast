//
//  Foundation+Extension.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import Foundation

extension CGFloat {
    
    static let timerSize = Constants.Size.timer
    static let timerRadius = Constants.Size.timerRadius
    static let buttonCornerRadius = Constants.Size.buttonCorner
    
    var degreeToRadian: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

extension Date {
    var minutes: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        let minutes = Int(formatter.string(from: self)) ?? 0
        
        return minutes
    }
    
    var hours: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let hours = Int(formatter.string(from: self)) ?? 0
        
        return hours
    }
}

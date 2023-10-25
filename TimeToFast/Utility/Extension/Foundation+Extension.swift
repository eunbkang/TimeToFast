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
    static let backgroundCornerRadius = Constants.Size.backgroundCorner
    
    var degreeToRadian: CGFloat {
        return self * .pi / 180
    }
}

extension CGPoint {
    static func pointOnCircle(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
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

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(firstNumber: Int, secondNumber: Int) -> String {
        return String(format: self.localized, firstNumber, secondNumber)
    }
    
    func localized(first: String, second: String, third: String, fourth: String) -> String {
        return String(format: self.localized, first, second, third, fourth)
    }
}

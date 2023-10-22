//
//  FastingPlan.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

enum FastingPlan: Int, CaseIterable {
    case twelve = 12
    case fourteen = 14
    case sixteen = 16
    case eighteen = 18
    case twenty = 20
    
    var eatingHours: Int {
        return 24 - self.rawValue
    }
    
    var title: String {
        return "\(self.rawValue) : \(eatingHours)"
    }
    
    var detail: String {
        return "planDetail".localized(firstNumber: self.rawValue, secondNumber: eatingHours)
    }
    
    var planButtonTitle: String {
        return "planButtonTitle".localized(firstNumber: self.rawValue, secondNumber: eatingHours)
    }
    
    var defaultEatingStartTime: Date {
        var hour: Int {
            switch self {
            case .twelve: return 8
            case .fourteen: return 10
            case .sixteen: return 12
            case .eighteen: return 12
            case .twenty: return 12
            }
        }
        return .setTimeForToday(hour: hour)
    }
}

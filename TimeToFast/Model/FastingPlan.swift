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
        return "Fast for \(self.rawValue) hours | Eat for \(eatingHours) hours"
    }
}

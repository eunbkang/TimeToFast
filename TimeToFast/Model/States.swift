//
//  States.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import Foundation

enum FastPlanType {
    case fast1410
    case fast1608
    case fast1806
    case fast2004
    
    var title: String {
        switch self {
        case .fast1410:
            return Constants.FastPlan.fast1410
        case .fast1608:
            return Constants.FastPlan.fast1608
        case .fast1806:
            return Constants.FastPlan.fast1806
        case .fast2004:
            return Constants.FastPlan.fast2004
        }
    }
    
    var planButtonTitle: String {
        return "\(title) FAST"
    }
}

enum FastState {
    case idle
    case fasting
    case eating
}

enum ShowTimeStatus {
    case showing
    case hiding
}

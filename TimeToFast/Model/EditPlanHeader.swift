//
//  EditPlanHeader.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import Foundation

struct EditPlanHeader {
    let image: String
    let title: String
}

enum EditPlanHeaderType: Int, CaseIterable {
    case weeklySchedule
    case fastingPlan
    case eatingPeriod
    
    var header: EditPlanHeader {
        switch self {
        case .weeklySchedule:
            return EditPlanHeader(image: "calendar", title: "WEEKLY SCHEDULE")
        case .fastingPlan:
            return EditPlanHeader(image: "flame.fill", title: "FASTING PLAN")
        case .eatingPeriod:
            return EditPlanHeader(image: "fork.knife", title: "EATING PERIOD")
        }
    }
}

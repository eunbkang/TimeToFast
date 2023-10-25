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
    
    case fastingInProgress
    case lastFasting
    
    case thisWeek
    case pastRecords
    
    var header: EditPlanHeader {
        switch self {
        case .weeklySchedule:
            return EditPlanHeader(image: "calendar", title: Localizing.Header.weeklySchedule)
        case .fastingPlan:
            return EditPlanHeader(image: "flame.fill", title: Localizing.Header.fastingPlan)
        case .eatingPeriod:
            return EditPlanHeader(image: "fork.knife", title: Localizing.Header.eatingPeriod)
        case .fastingInProgress:
            return EditPlanHeader(image: "flame.fill", title: Localizing.Header.fastingInProgress)
        case .lastFasting:
            return EditPlanHeader(image: "flame.fill", title: Localizing.Header.lastFastingResult)
        case .thisWeek:
            return EditPlanHeader(image: "chart.bar.fill", title: Localizing.Header.thisWeek)
        case .pastRecords:
            return EditPlanHeader(image: "calendar", title: Localizing.Header.pastRecords)
        }
    }
}

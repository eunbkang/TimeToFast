//
//  FastState.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import Foundation

enum FastState {
    case idle
    case fasting
    case eating
    case fastingBreak
    case fastingEarly
    
    var fastControl: String {
        switch self {
        case .idle, .eating:
            return Constants.FastControl.startEarly
        case .fasting, .fastingEarly:
            return Constants.FastControl.breakFast
        case .fastingBreak:
            return Constants.FastControl.resumeFast
        }
    }
    
    var stateTitle: String {
        switch self {
        case .idle:
            return Constants.StateTitle.idle
        case .fasting, .fastingEarly:
            return Constants.StateTitle.fasting
        case .eating:
            return Constants.StateTitle.eating
        case .fastingBreak:
            return Constants.StateTitle.breakFast
        }
    }
    
    var timeStatus: String {
        switch self {
        case .idle, .fasting, .fastingEarly, .fastingBreak:
            return Constants.TimeStatus.base
        case .eating:
            return Constants.TimeStatus.eating
        }
    }
    
    var recordTimeCardHeaderType: EditPlanHeaderType {
        switch self {
        case .idle:
            return .fastingPlan
        case .fasting, .fastingEarly:
            return .fastingInProgress
        case .eating, .fastingBreak:
            return .lastFasting
        }
    }
    
    var recordTimeCardsTitle: TimeCardTitle {
        switch self {
        case .idle:
            return TimeCardTitle(left: Localizing.Time.starts, right: Localizing.Time.ends)
        case .fasting, .fastingEarly:
            return TimeCardTitle(left: Localizing.Time.started, right: Localizing.Time.goal)
        case .eating, .fastingBreak:
            return TimeCardTitle(left: Localizing.Time.started, right: Localizing.Time.ended)
        }
    }
}

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
    
    var fastControl: String {
        switch self {
        case .idle, .eating:
            return Constants.FastControl.start
        case .fasting:
            return Constants.FastControl.end
        }
    }
    
    var stateTitle: String {
        switch self {
        case .idle:
            return Constants.StateTitle.idle
        case .fasting:
            return Constants.StateTitle.fasting
        case .eating:
            return Constants.StateTitle.eating
        }
    }
    
    var timeStatus: String {
        switch self {
        case .idle, .fasting:
            return Constants.TimeStatus.base
        case .eating:
            return Constants.TimeStatus.eating
        }
    }
    
    var recordTimeCardHeaderType: EditPlanHeaderType {
        switch self {
        case .idle:
            return .fastingPlan
        case .fasting:
            return .fastingInProgress
        case .eating:
            return .lastFasting
        }
    }
    
    var recordTimeCardsTitle: TimeCardTitle {
        switch self {
        case .idle:
            return TimeCardTitle(left: "STARTS", right: "ENDS")
        case .fasting:
            return TimeCardTitle(left: "STARTED", right: "GOAL")
        case .eating:
            return TimeCardTitle(left: "STARTED", right: "ENDED")
        }
    }
}

enum TimerStatus {
    case playing
    case stopped
    
    var title: String {
        switch self {
        case .playing:
            return Constants.TimerControl.playing
        case .stopped:
            return Constants.TimerControl.stopped
        }
    }
    
    var image: String {
        switch self {
        case .playing:
            return Constants.TimerControl.playingImage
        case .stopped:
            return Constants.TimerControl.stoppedImage
        }
    }
}

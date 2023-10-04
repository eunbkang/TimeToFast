//
//  TimerViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/04.
//

import Foundation

class TimerViewModel {
    
    var stateTitle = Observable(Constants.StateTitle.idle)
    var timeCounter = Observable("00:00:00")
    
}

//
//  PlanViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import Foundation

final class PlanViewModel {
    
    var planSetting = Observable(PlanSetting(plan: .sixteen, eatingStartTime: Date()-60*60*2))
    
}

//
//  Protocol.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/10.
//

import Foundation

protocol SetTimeDelegate: AnyObject {
    func didReceiveEditedTime(type: EditTimeType, time: Date)
}

protocol SetPlanDelegate: AnyObject {
    func didSavedPlanSetting()
}

protocol SelectedFastingPlanDelegate: AnyObject {
    func didSelectedFastingPlan(plan: FastingPlan)
}

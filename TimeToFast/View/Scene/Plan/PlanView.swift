//
//  PlanView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class PlanView: BaseView {

    let weeklyScheduleView = WeeklyScheduleView()

    
//    private let fastingPlanHeaderView: PlanHeaderView = {
//        let view = PlanHeaderView(type: .fastingPlan)
//
//        return view
//    }()
//
//    private let eatingPeriodHeaderView: PlanHeaderView = {
//        let view = PlanHeaderView(type: .eatingPeriod)
//
//        return view
//    }()
    
    
    
    override func configViewHierarchy() {
        addSubview(weeklyScheduleView)
    }
    
    override func configLayoutConstraints() {
        weeklyScheduleView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

//
//  PlanView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class PlanView: BaseView {

    let weeklyScheduleView = WeeklyScheduleView()

    let fastingPlanView = FastingPlanView()
    
    override func configViewHierarchy() {
        addSubview(weeklyScheduleView)
        addSubview(fastingPlanView)
    }
    
    override func configLayoutConstraints() {
        weeklyScheduleView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        fastingPlanView.snp.makeConstraints { make in
            make.top.equalTo(weeklyScheduleView.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(102)
        }
    }
}

//
//  PlanView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class PlanView: BaseView {

    var planSetting: PlanSetting {
        didSet {
            configPlanSettingToView()
        }
    }
    
    let weeklyScheduleView = WeeklyScheduleView()

    lazy var fastingPlanView = FastingPlanView(planSetting: planSetting)
    
    lazy var eatingPeriodView = EatingPeriodView(planSetting: planSetting)
    
    init(planSetting: PlanSetting) {
        self.planSetting = planSetting
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configPlanSettingToView() {
        fastingPlanView.planSetting = planSetting
        eatingPeriodView.planSetting = planSetting
    }
    
    override func configViewHierarchy() {
        addSubview(weeklyScheduleView)
        addSubview(fastingPlanView)
        addSubview(eatingPeriodView)
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
        
        eatingPeriodView.snp.makeConstraints { make in
            make.top.equalTo(fastingPlanView.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(102)
        }
    }
}

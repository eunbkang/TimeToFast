//
//  EatingPeriodView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class EatingPeriodView: BaseView {
    
    var planSetting: PlanSetting {
        didSet {
            configPlanSettingToView()
        }
    }
    
    private let headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: .eatingPeriod)
        
        return view
    }()
    
    lazy var fromTimeView = EatingPeriodTimeView(type: .from, planSetting: planSetting)
    
    private lazy var toTimeView = EatingPeriodTimeView(type: .to, planSetting: planSetting)
    
    private lazy var eatingPeriodStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fromTimeView, toTimeView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    init(planSetting: PlanSetting) {
        self.planSetting = planSetting
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configPlanSettingToView() {
        fromTimeView.planSetting = planSetting
        toTimeView.planSetting = planSetting
    }
    
    override func configViewHierarchy() {
        addSubview(headerView)
        addSubview(eatingPeriodStackView)
    }
    
    override func configLayoutConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        eatingPeriodStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.height.equalTo(72)
        }
    }
}

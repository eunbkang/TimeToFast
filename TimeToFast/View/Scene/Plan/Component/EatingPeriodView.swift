//
//  EatingPeriodView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class EatingPeriodView: BaseView {
    
    var planSetting = PlanSetting(eatingStartTime: Date()-60*60*4)
    
    private let headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: .eatingPeriod)
        
        return view
    }()
    
    private lazy var fromTimeView = EatingPeriodTimeView(type: .from, planSetting: planSetting)
    
    private lazy var toTimeView = EatingPeriodTimeView(type: .to, planSetting: planSetting)
    
    private lazy var eatingPeriodStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fromTimeView, toTimeView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    override func configViewHierarchy() {
        addSubview(headerView)
        addSubview(eatingPeriodStackView)
    }
    
    override func configLayoutConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        eatingPeriodStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.height.equalTo(72)
        }
    }
}

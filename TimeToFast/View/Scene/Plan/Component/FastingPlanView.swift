//
//  FastingPlanView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class FastingPlanView: BaseView {
    
    private let headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: .fastingPlan)
        
        return view
    }()
    
    private let backgroundRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightGray
        view.layer.borderColor = UIColor.mainPurple.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constants.Size.backgroundCorner
        view.clipsToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "14:10"
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.textColor = .black
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Fast for 14 hours | Eat for 10 hours"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 4
        
        return view
    }()
    
    override func configViewHierarchy() {
        addSubview(headerView)
        addSubview(backgroundRectangle)
        backgroundRectangle.addSubview(labelStackView)
    }
    
    override func configLayoutConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        backgroundRectangle.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.height.equalTo(72)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Size.edgePadding)
            make.centerY.equalToSuperview()
        }
    }
    
}

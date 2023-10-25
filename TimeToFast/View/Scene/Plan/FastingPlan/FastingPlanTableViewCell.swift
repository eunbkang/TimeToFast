//
//  FastingPlanTableViewCell.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class FastingPlanTableViewCell: BaseTableViewCell {
    
    private let backgroundRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightGray
        view.layer.cornerRadius = Constants.Size.backgroundCorner
        view.clipsToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.textColor = .black
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
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
    
    func configPlanToView(plan: FastingPlan, selectedPlan: FastingPlan?) {
        titleLabel.text = plan.title
        detailLabel.text = plan.detail
        
        guard let selectedPlan = selectedPlan else { return }
        if plan == selectedPlan {
            backgroundRectangle.layer.borderColor = UIColor.mainPurple.cgColor
            backgroundRectangle.layer.borderWidth = 1
        } else {
            backgroundRectangle.layer.borderWidth = 0
        }
    }
    
    override func configViewComponents() {
        selectionStyle = .none
        
        contentView.addSubview(backgroundRectangle)
        backgroundRectangle.addSubview(labelStackView)
    }
    
    override func configLayoutConstraints() {
        backgroundRectangle.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Size.edgePadding)
            make.centerY.equalToSuperview()
        }
    }
}

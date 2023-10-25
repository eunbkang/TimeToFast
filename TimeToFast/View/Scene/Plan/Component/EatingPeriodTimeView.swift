//
//  EatingPeriodTimeView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

enum EatingPeriodTimeViewType {
    case from
    case to
}

class EatingPeriodTimeView: UIView {
    
    var type: EatingPeriodTimeViewType
    var planSetting: PlanSetting {
        didSet {
            configTimerSettingToView()
        }
    }
    
    private lazy var backgroundRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightGray
        view.layer.cornerRadius = Constants.Size.backgroundCorner
        view.clipsToBounds = true
        
        return view
    }()
    
    private let fromToLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    private let editImageView: UIImageView = {
        let view = UIImageView()
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote))
        view.image = UIImage(systemName: "pencil", withConfiguration: config)
        view.tintColor = .black
        
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3, weight: .heavy)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fromToLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    init(type: EatingPeriodTimeViewType, planSetting: PlanSetting) {
        self.type = type
        self.planSetting = planSetting
        super.init(frame: .zero)
        
        configViewHierarchy()
        configLayoutConstraints()
        configTimerSettingToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configTimerSettingToView() {
        switch type {
        case .from:
            dateLabel.text = planSetting.eatingStartTime.dateToTimeOnlyString()
        case .to:
            dateLabel.text = planSetting.eatingEndTime?.dateToTimeOnlyString()
        }
    }
    
    private func configViewHierarchy() {
        addSubview(backgroundRectangle)
        addSubview(labelStackView)
        
        switch type {
        case .from:
            backgroundRectangle.layer.borderColor = UIColor.mainGreen.cgColor
            backgroundRectangle.layer.borderWidth = 1
            
            fromToLabel.text = Localizing.Time.from
            addSubview(editImageView)
        case .to:
            fromToLabel.text = Localizing.Time.to
        }
    }
    
    private func configLayoutConstraints() {
        backgroundRectangle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labelStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        if type == .from {
            editImageView.snp.makeConstraints { make in
                make.centerY.equalTo(fromToLabel.snp.centerY)
                make.leading.equalTo(fromToLabel.snp.trailing).offset(8)
            }
        }
    }
}

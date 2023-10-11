//
//  SetTimeView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import UIKit

enum SetTimeViewType {
    case started
    case goal
}

class SetTimeView: UIView {
    
    var viewType: SetTimeViewType
    
    var fastState: FastState {
        didSet {
            configStateToView()
        }
    }
    
    var timerSetting: TimerSetting {
        didSet {
            configTimerSettingToView()
        }
    }
    
    private lazy var backgroundRectangle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .buttonCornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let editImageView: UIImageView = {
        let view = UIImageView()
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote))
        view.image = UIImage(systemName: "pencil", withConfiguration: config)
        view.tintColor = .systemGray
        
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    init(viewType: SetTimeViewType, fastState: FastState, timerSetting: TimerSetting) {
        self.viewType = viewType
        self.fastState = fastState
        self.timerSetting = timerSetting
        super.init(frame: .zero)
        
        configViewHierarchy()
        configLayoutConstraints()
        configTimerSettingToView()
        configStateToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configStateToView() {
        backgroundRectangle.backgroundColor = fastState == .idle ? Constants.Color.veryLightGray : .white.withAlphaComponent(0.5)
    }
    
    private func configTimerSettingToView() {
        switch viewType {
        case .started:
            dateLabel.text = timerSetting.fastStartTime.dateToSetTimeString()
        case .goal:
            dateLabel.text = timerSetting.fastEndTime.dateToSetTimeString()
        }
    }
    
    private func configViewHierarchy() {
        addSubview(backgroundRectangle)
        addSubview(labelStackView)
        
        if viewType == .started {
            addSubview(editImageView)
            titleLabel.text = Constants.SetTimeTitle.started
        } else {
            titleLabel.text = Constants.SetTimeTitle.goal
        }
    }
    
    private func configLayoutConstraints() {
        backgroundRectangle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labelStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        if viewType == .started {
            editImageView.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel.snp.centerY)
                make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            }
        }
    }
}

//
//  TimerView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import UIKit

final class TimerView: UIView {
    
    // MARK: - Properties
    
    var backgroundLayer: BackgroundGradientLayer = {
        let layer = BackgroundGradientLayer(layer: FastState.idle)
        
        return layer
    }()
    
    let timeToggleButton: TimeToggleButton = {
        let button = TimeToggleButton()
        
        return button
    }()
    
    lazy var planButton: FastPlanButton = {
        let button = FastPlanButton()
        
        return button
    }()
    
    let stateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    let timeStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .systemGray
        
        return label
    }()
    
    var timeCounterLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle, weight: .heavy)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var counterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeStatusLabel, timeCounterLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    lazy var fastControlButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = Constants.Size.buttonCorner
        button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.20
        button.layer.shadowRadius = 15
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.masksToBounds = false
        
        return button
    }()
    
    lazy var circularTimerView: CircularTimerView = {
        let view = CircularTimerView(fastState: fastState, timerSetting: timerSetting)
        
        return view
    }()
    
    var fastState: FastState = .idle {
        didSet {
            configFastingStateToView()
        }
    }
    
    var timerSetting = TimerSetting(fastStartTime: Date() - 60*60*9)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        configViewHierarchy()
        configLayoutConstraints()
        configFastingStateToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configFastingStateToView() {
        stateTitleLabel.text = fastState.stateTitle
        timeStatusLabel.text = fastState.timeStatus
        fastControlButton.setTitle(fastState.fastControl, for: .normal)
        
        backgroundLayer.fastState = fastState
        timeToggleButton.fastState = fastState
        planButton.fastState = fastState
        circularTimerView.fastState = fastState
    }
    
    private func configViewHierarchy() {
        let components = [timeToggleButton, planButton, stateTitleLabel, circularTimerView]
        components.forEach { item in
            addSubview(item)
        }
        
        circularTimerView.addSubview(counterStackView)
        circularTimerView.addSubview(fastControlButton)
    }
    
    private func configLayoutConstraints() {
        timeToggleButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.Size.edgePadding)
        }
        planButton.snp.makeConstraints { make in
            make.top.equalTo(timeToggleButton)
            make.trailing.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        stateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeToggleButton.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        circularTimerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Constants.Size.timer)
            make.height.equalTo(circularTimerView.snp.width)
            make.top.equalTo(stateTitleLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }
        
        counterStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-32)
        }
        fastControlButton.snp.makeConstraints { make in
            make.top.equalTo(counterStackView.snp.bottom).offset(32)
            make.centerX.equalTo(counterStackView)
            make.height.equalTo(36)
            make.width.equalTo(100)
        }
    }
}

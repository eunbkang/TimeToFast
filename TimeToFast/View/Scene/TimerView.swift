//
//  TimerView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import UIKit

final class TimerView: UIView {
    
    // MARK: - Properties
    
    var backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [Constants.Color.lightPurple.cgColor, Constants.Color.lightGreen.cgColor]
        layer.locations = [0.25]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.25)

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
        label.text = "It's time to fast!"
        
        return label
    }()
    
    let timeStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .systemGray
        label.text = "REMAINING TIME"
        
        return label
    }()
    
    let timeCounterLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle, weight: .heavy)
        label.textColor = .black
        label.text = "00:00:00"
        
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
        
        button.layer.cornerRadius = Constants.Corner.button
        button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 15
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.masksToBounds = false
        
        return button
    }()
    
    var fastState: FastState = .idle {
        didSet {
            fastControlButton.setTitle(fastState.fastControl, for: .normal)
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configViewHierarchy()
        configLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configViewHierarchy() {
        let components = [timeToggleButton, planButton, stateTitleLabel, counterStackView, fastControlButton]
        
        components.forEach { item in
            addSubview(item)
        }
    }
    
    private func configLayoutConstraints() {
        timeToggleButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.Padding.edge)
        }
        planButton.snp.makeConstraints { make in
            make.top.equalTo(timeToggleButton)
            make.trailing.equalToSuperview().inset(Constants.Padding.edge)
        }
        stateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeToggleButton.snp.bottom).offset(36)
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

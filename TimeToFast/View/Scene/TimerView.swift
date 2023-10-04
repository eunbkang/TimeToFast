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
        layer.colors = [Constants.Color.lightPurple.withAlphaComponent(0.75).cgColor, Constants.Color.lightGreen.withAlphaComponent(0.75).cgColor]
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
        button.layer.shadowOpacity = 0.20
        button.layer.shadowRadius = 15
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.masksToBounds = false
        
        return button
    }()
    
    lazy var timerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let timerSize = UIScreen.main.bounds.width * 0.78
    
    lazy var fastingPath: UIBezierPath = {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: 0.4625 * timerSize,
            startAngle: timer.fastStartAngle,
            endAngle: timer.fastEndAngle,
            clockwise: true
        )
        return path
    }()
    
    lazy var fastingTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = fastingPath.cgPath
        layer.strokeColor = Constants.Color.lightPurple.cgColor
        layer.lineWidth = 0.4625 * timerSize * 0.1
        layer.lineCap = .square
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    lazy var fastingProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = fastingPath.cgPath
        layer.strokeColor = Constants.Color.mainPurple.cgColor
        layer.lineWidth = 0.4625 * timerSize * 0.15
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    lazy var eatingPath: UIBezierPath = {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: 0.4625 * timerSize,
            startAngle: timer.fastEndAngle,
            endAngle: timer.fastStartAngle,
            clockwise: true
        )
        return path
    }()
    
    lazy var eatingTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = eatingPath.cgPath
        layer.strokeColor = Constants.Color.lightGreen.cgColor
        layer.lineWidth = 0.4625 * timerSize * 0.1
        layer.lineCap = .square
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    lazy var eatingProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = eatingPath.cgPath
        layer.strokeColor = Constants.Color.mainGreen.cgColor
        layer.lineWidth = 0.4625 * timerSize * 0.15
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    
    var fastState: FastState = .idle {
        didSet {
            fastControlButton.setTitle(fastState.fastControl, for: .normal)
        }
    }
    
    var timer = Timer(
        fastStartTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 0)) ?? Date(),
        fastEndTime: Calendar.current.date(from: DateComponents(hour: 12, minute: 0)) ?? Date()
    )
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        configViewHierarchy()
        configLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configViewHierarchy() {
        let components = [timeToggleButton, planButton, stateTitleLabel, timerView]
        components.forEach { item in
            addSubview(item)
        }
        
        timerView.layer.addSublayer(fastingTrackLayer)
        timerView.layer.addSublayer(fastingProgressLayer)
        timerView.layer.addSublayer(eatingTrackLayer)
        timerView.layer.addSublayer(eatingProgressLayer)
        
        timerView.addSubview(counterStackView)
        timerView.addSubview(fastControlButton)
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
        timerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.78)
            make.height.equalTo(timerView.snp.width)
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

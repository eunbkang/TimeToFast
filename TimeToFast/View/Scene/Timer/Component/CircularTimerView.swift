//
//  CircularTimerView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import UIKit

class CircularTimerView: UIView {
    
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
    
    private let timerSize = UIScreen.main.bounds.width * .timerSize
    
    private lazy var fastingTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = Constants.Color.lightPurple.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.1
        layer.lineCap = .butt
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var fastingProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = Constants.Color.mainPurple.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.15
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var eatingTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = Constants.Color.lightGreen.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.1
        layer.lineCap = .butt
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var eatingProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = Constants.Color.mainGreen.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.15
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var clockImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "timerClock")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var fastingSymbolBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.mainPurple.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = timerSize * 0.098 / 2
        view.clipsToBounds = true

        return view
    }()
    
    private let flameLabel: UILabel = {
        let label = UILabel()
        label.text = "🔥"
        label.font = .preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var eatingSymbolBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.mainGreen.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = timerSize * 0.098 / 2
        view.clipsToBounds = true

        return view
    }()
    
    private let foodLabel: UILabel = {
        let label = UILabel()
        let foods = ["🍔", "🌮", "🍕", "🥘", "🍱", "🥯", "🍛", "🍳", "🍝", "🍜"]
        label.text = foods.randomElement()!
        label.font = .preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        
        return label
    }()
        
    init(fastState: FastState, timerSetting: TimerSetting) {
        self.fastState = fastState
        self.timerSetting = timerSetting
        super.init(frame: .zero)
        
        configTimerSettingToView()
        configLayer()
        configClock()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLayer() {
        [fastingTrackLayer, eatingTrackLayer, fastingProgressLayer, eatingProgressLayer].forEach { circularLayer in
            layer.addSublayer(circularLayer)
        }
        configStateToView()
    }
    
    private func configStateToView() {
        switch fastState {
        case .idle:
            fastingProgressLayer.isHidden = true
            eatingProgressLayer.isHidden = true
            
        case .fasting, .fastingBreak, .fastingEarly:
            fastingProgressLayer.isHidden = false
            eatingProgressLayer.isHidden = true
            
        case .eating:
            eatingProgressLayer.isHidden = false
            fastingProgressLayer.isHidden = false
        }
    }
    
    private func configTimerSettingToView() {
        let center = CGPoint(x: timerSize / 2, y: timerSize / 2)
        let radius = timerSize * .timerRadius
        let lineWidth = .timerRadius * timerSize * 0.15 - 8
        
        let fastingTrackPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: timerSetting.fastStartAngle,
            endAngle: timerSetting.fastEndAngle,
            clockwise: true
        )
        let fastingProgressPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: timerSetting.fastStartAngle,
            endAngle: configFastingProgressEndAngle(),
            clockwise: true
        )
        let eatingTrackPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: timerSetting.fastEndAngle,
            endAngle: timerSetting.fastStartAngle,
            clockwise: true
        )
        let eatingProgressPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: timerSetting.fastEndAngle,
            endAngle: Date().dateToAngle(),
            clockwise: true
        )

        fastingTrackLayer.path = fastingTrackPath.cgPath
        fastingProgressLayer.path = fastingProgressPath.cgPath
        eatingTrackLayer.path = eatingTrackPath.cgPath
        eatingProgressLayer.path = eatingProgressPath.cgPath
        
        configSymbolImage()
    }
    
    private func configFastingProgressEndAngle() -> CGFloat {
        let currentAngle = Date().dateToAngle()
        let timerEndAngle = timerSetting.fastEndAngle
        
        print(currentAngle, timerEndAngle)
        
        if fastState == .eating {
            return timerEndAngle
        } else {
            if currentAngle < timerEndAngle {
                return currentAngle
            } else {
                return timerEndAngle
            }
        }
    }
    
    private func configClock() {
        addSubview(clockImageView)
        clockImageView.snp.makeConstraints { make in
            make.size.equalTo(timerSize * 0.82)
            make.center.equalToSuperview()
        }
    }
    
    private func configSymbolImage() {
        let fastingAngle: CGFloat = timerSetting.fastStartAngle
        let eatingAngle: CGFloat = timerSetting.fastEndAngle
        let center = CGPoint(x: timerSize / 2, y: timerSize / 2)
        let radius = timerSize * .timerRadius
        
        addSubview(fastingSymbolBackView)
        addSubview(eatingSymbolBackView)
        
        flameLabel.center = CGPoint.pointOnCircle(center: center, radius: radius, angle: fastingAngle)
        foodLabel.center = CGPoint.pointOnCircle(center: center, radius: radius, angle: eatingAngle)
        
        addSubview(flameLabel)
        addSubview(foodLabel)
        
        fastingSymbolBackView.snp.makeConstraints { make in
            make.size.equalTo(timerSize * 0.098)
            make.center.equalTo(flameLabel)
        }
        
        eatingSymbolBackView.snp.makeConstraints { make in
            make.size.equalTo(timerSize * 0.098)
            make.center.equalTo(foodLabel)
        }
    }
}

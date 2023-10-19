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
        layer.lineCap = .square
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
        layer.lineCap = .square
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
            
        case .fasting:
            fastingProgressLayer.isHidden = false
            eatingProgressLayer.isHidden = true
            
        case .eating:
            eatingProgressLayer.isHidden = false
            fastingProgressLayer.isHidden = false
        }
    }
    
    private func configTimerSettingToView() {
        let fastingTrackPath = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastStartAngle,
            endAngle: timerSetting.fastEndAngle,
            clockwise: true
        )
        let fastingProgressPath = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastStartAngle,
            endAngle: Date().dateToAngle(),
            clockwise: true
        )
        let eatingTrackPath = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastEndAngle,
            endAngle: timerSetting.fastStartAngle,
            clockwise: true
        )
        let eatingProgressPath = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastEndAngle,
            endAngle: Date().dateToAngle(),
            clockwise: true
        )

        fastingTrackLayer.path = fastingTrackPath.cgPath
        fastingProgressLayer.path = fastingProgressPath.cgPath
        eatingTrackLayer.path = eatingTrackPath.cgPath
        eatingProgressLayer.path = eatingProgressPath.cgPath
    }
    
    private func configClock() {
        addSubview(clockImageView)
        clockImageView.snp.makeConstraints { make in
            make.size.equalTo(timerSize * 0.83)
            make.center.equalToSuperview()
        }
    }
}

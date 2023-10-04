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
    
    var timerSetting: TimerSetting
    
    private let timerSize = UIScreen.main.bounds.width * .timerSize
    
    private lazy var fastingTrackPath: UIBezierPath = {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastStartAngle,
            endAngle: timerSetting.fastEndAngle,
            clockwise: true
        )
        return path
    }()
    
    private lazy var fastingTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = fastingTrackPath.cgPath
        layer.strokeColor = Constants.Color.lightPurple.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.1
        layer.lineCap = .square
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var fastingProgressPath: UIBezierPath = {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastStartAngle,
            endAngle: Date().dateToAngle(),
            clockwise: true
        )
        return path
    }()
    
    private lazy var fastingProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = fastingProgressPath.cgPath
        layer.strokeColor = Constants.Color.mainPurple.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.15
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var eatingTrackPath: UIBezierPath = {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastEndAngle,
            endAngle: timerSetting.fastStartAngle,
            clockwise: true
        )
        return path
    }()
    
    private lazy var eatingTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = eatingTrackPath.cgPath
        layer.strokeColor = Constants.Color.lightGreen.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.1
        layer.lineCap = .square
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    private lazy var eatingProgressPath: UIBezierPath = {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: .timerRadius * timerSize,
            startAngle: timerSetting.fastEndAngle,
            endAngle: timerSetting.fastStartAngle,
            clockwise: true
        )
        return path
    }()
    
    private lazy var eatingProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = eatingProgressPath.cgPath
        layer.strokeColor = Constants.Color.mainGreen.cgColor
        layer.lineWidth = .timerRadius * timerSize * 0.15
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
        
    init(fastState: FastState, timerSetting: TimerSetting) {
        self.fastState = fastState
        self.timerSetting = timerSetting
        super.init(frame: .zero)
        
        configLayer()
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
            fastingProgressLayer.isHidden = false
            eatingProgressLayer.isHidden = false
        }
    }
}

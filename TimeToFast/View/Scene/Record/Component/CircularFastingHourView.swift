//
//  CircularFastingHourView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/18.
//

import UIKit

class CircularFastingHourView: UIView {
    
    var fastingRecord: FastingRecordTable {
        didSet {
            configFastingTimeToView()
        }
    }
    
    private let timerSize: CGFloat = Constants.Size.FastingCircle.width
    private let timerLineWidth: CGFloat = Constants.Size.FastingCircle.line
    private lazy var timerRadius = timerSize/2 + timerLineWidth/2
    
    private lazy var fastingHourShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = timerLineWidth
        layer.lineCap = .round
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    init(fastingRecord: FastingRecordTable) {
        self.fastingRecord = fastingRecord
        super.init(frame: .zero)
        
        configLayer()
        configFastingTimeToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLayer() {
        layer.addSublayer(fastingHourShapeLayer)
    }
    
    private func configFastingTimeToView() {
        let fastingHourPath = UIBezierPath(
            arcCenter: CGPoint(x: timerSize / 2, y: timerSize / 2),
            radius: timerSize/2,
            startAngle: fastingRecord.fastingStartTime.dateToAngle(),
            endAngle: fastingRecord.fastingEndTime.dateToAngle(),
            clockwise: true
        )
        
        fastingHourShapeLayer.path = fastingHourPath.cgPath
        
        fastingHourShapeLayer.strokeColor = fastingRecord.isGoalAchieved ? UIColor.mainPurple.cgColor : UIColor.lightPurple.cgColor
    }
}

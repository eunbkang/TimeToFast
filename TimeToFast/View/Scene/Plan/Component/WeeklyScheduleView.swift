//
//  WeeklyScheduleView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class WeeklyScheduleView: BaseView {
    
    private let weeklyHeaderView: PlanHeaderView = {
        let view = PlanHeaderView(type: .weeklySchedule)
        
        return view
    }()
    
    private let backgroundRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightGray
        view.layer.cornerRadius = Constants.Size.backgroundCorner
        view.clipsToBounds = true
        
        return view
    }()
    
    private var mondayButton = CircularDayButton(day: .mon, status: .selected)
    private var tuesdayButton = CircularDayButton(day: .tue, status: .selected)
    private var wednesdayButton = CircularDayButton(day: .wed, status: .selected)
    private var thursdayButton = CircularDayButton(day: .thu, status: .selected)
    private var fridayButton = CircularDayButton(day: .fri, status: .selected)
    private var saturdayButton = CircularDayButton(day: .sat, status: .selected)
    private var sundayButton = CircularDayButton(day: .sat, status: .selected)
    
    private lazy var daysButton = [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    
    private lazy var daysStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: daysButton)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        
        return stackView
    }()
    
    override func configViewHierarchy() {
        addSubview(weeklyHeaderView)
        addSubview(backgroundRectangle)
        addSubview(daysStackView)
    }
    
    override func configLayoutConstraints() {
        
        weeklyHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        backgroundRectangle.snp.makeConstraints { make in
            make.top.equalTo(weeklyHeaderView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.height.equalTo(70)
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let inset: CGFloat = 14
        let circleSize = (screenWidth - (6 * 6) - (inset * 2) - (Constants.Size.edgePadding * 2)) / 7
        
        for button in daysButton {
            button.layer.cornerRadius = circleSize / 2
            button.clipsToBounds = true
            button.snp.makeConstraints { make in
                make.size.equalTo(circleSize)
            }
        }
        
        daysStackView.snp.makeConstraints { make in
            make.center.equalTo(backgroundRectangle)
        }
    }
}

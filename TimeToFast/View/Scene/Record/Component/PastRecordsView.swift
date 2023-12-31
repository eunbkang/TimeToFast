//
//  PastRecordsView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit
import FSCalendar

final class PastRecordsView: BaseView {
    
    private let headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: .pastRecords)
        
        return view
    }()
    
    private let backgroundRect: BackShadowView = {
        let view = BackShadowView()
        
        return view
    }()
    
    private let calendarBackView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let calendarView: FSCalendar = {
        let view = FSCalendar()
        view.scope = .month
        
        return view
    }()
    
    let nextMonthButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .headline)))
        button.setImage(image, for: .normal)
        button.tintColor = .darkPurple
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        return button
    }()
    
    let previousMonthButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .headline)))
        button.setImage(image, for: .normal)
        button.tintColor = .darkPurple
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousMonthButton, nextMonthButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.text = Date().yearAndMonth()
        
        return label
    }()
    
    override func configViewHierarchy() {
        configCalendarStyle()
        
        addSubview(headerView)
        addSubview(backgroundRect)
        backgroundRect.addSubview(calendarBackView)
        calendarBackView.addSubview(calendarView)
        calendarBackView.addSubview(headerLabel)
        calendarBackView.addSubview(buttonStackView)
    }
    
    override func configLayoutConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        
        backgroundRect.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.height.equalTo(332)
        }
        
        calendarBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            make.leading.equalTo(calendarView.collectionView).offset(8)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.trailing.equalTo(calendarView.collectionView).inset(8)
        }
    }
    
    private func configCalendarStyle() {
        calendarView.headerHeight = 42
        calendarView.weekdayHeight = 20
        calendarView.backgroundColor = .white
        calendarView.placeholderType = .none
        
        calendarView.firstWeekday = 2
        calendarView.appearance.caseOptions = .weekdayUsesUpperCase
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.headerTitleColor = .clear
        calendarView.appearance.headerTitleFont = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        
        calendarView.appearance.weekdayTextColor = .systemGray3
        calendarView.appearance.weekdayFont = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        calendarView.appearance.titleFont = .preferredFont(forTextStyle: .body)
        calendarView.appearance.borderSelectionColor = .mainPurple
        
    }
}

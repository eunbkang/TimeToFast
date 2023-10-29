//
//  RecordTimeCardView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/12.
//

import UIKit

class RecordTimeCardView: UIView {
    
    var fastState: FastState {
        didSet {
            setFastStateToView()
            setRecordCardTimeToView()
            setRecordStatusToView()
            showOrHideEditImage()
        }
    }
    
    var recordCardTime: RecordCardTime {
        didSet {
            setRecordCardTimeToView()
        }
    }
    
    var recordStatus: RecordStatus {
        didSet {
            setRecordStatusToView()
            showOrHideEditImage()
        }
    }
    
    var isStartTimeEditable: Bool {
        didSet {
            showOrHideEditImage()
            setRecordStatusToView()
        }
    }
    
    var isEndTimeEditable: Bool {
        didSet {
            showOrHideEditImage()
            setRecordStatusToView()
        }
    }
    
    private var backgroundRectangle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .backgroundCornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: fastState.recordTimeCardHeaderType)
        
        return view
    }()
    
    lazy var leftTimeView: SetTimeView = {
        let view = SetTimeView(
            title: fastState.recordTimeCardsTitle.left,
            date: recordCardTime.startString(status: fastState),
            fastState: fastState
        )
        
        return view
    }()
    
    lazy var rightTimeView: SetTimeView = {
        let view = SetTimeView(
            title: fastState.recordTimeCardsTitle.right,
            date: recordCardTime.endString(status: fastState),
            fastState: fastState
        )
        
        return view
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftTimeView, rightTimeView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var saveButton: TimeCardSaveButton = {
        let button = TimeCardSaveButton(status: recordStatus)
        
        return button
    }()
    
    init(fastState: FastState, recordCardTime: RecordCardTime, recordStatus: RecordStatus, isStartTimeEditable: Bool, isEndTimeEditable: Bool) {
        self.fastState = fastState
        self.recordCardTime = recordCardTime
        self.recordStatus = recordStatus
        self.isStartTimeEditable = isStartTimeEditable
        self.isEndTimeEditable = isEndTimeEditable
        super.init(frame: .zero)
        
        configViewHierarchy()
        configLayoutConstraints()
        
        setFastStateToView()
        setRecordStatusToView()
        setRecordCardTimeToView()
        showOrHideEditImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViewHierarchy() {
        addSubview(backgroundRectangle)
        backgroundRectangle.addSubview(headerView)
        backgroundRectangle.addSubview(saveButton)
        backgroundRectangle.addSubview(timeStackView)
    }
    
    private func configLayoutConstraints() {
        backgroundRectangle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.trailing.equalToSuperview().inset(12)
        }
        headerView.snp.makeConstraints { make in
            make.centerY.equalTo(saveButton.snp.centerY)
            make.leading.equalToSuperview().inset(12)
        }
        timeStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setFastStateToView() {
        let idleColor: UIColor = .veryLightGray
        let runningColor: UIColor = .white.withAlphaComponent(0.5)
        
        backgroundRectangle.backgroundColor = fastState == .idle || fastState == .fastingBreak ? idleColor : runningColor
        
        headerView.type = fastState.recordTimeCardHeaderType
        
        leftTimeView.fastState = fastState
        leftTimeView.title = fastState.recordTimeCardsTitle.left
        leftTimeView.date = recordCardTime.startString(status: fastState)
        
        rightTimeView.fastState = fastState
        rightTimeView.title = fastState.recordTimeCardsTitle.right
        rightTimeView.date = recordCardTime.endString(status: fastState)
    }
    
    private func setRecordStatusToView() {
        saveButton.status = recordStatus
        saveButton.isEnabled = recordStatus == .notSaved ? true : false
        
        configTimeViewEditable(for: leftTimeView, isEditable: isStartTimeEditable)
        configTimeViewEditable(for: rightTimeView, isEditable: isEndTimeEditable)
        
        let isSaveShowable = fastState == .eating || fastState == .fastingBreak
        saveButton.isHidden = isSaveShowable ? false : true
    }
    
    private func configTimeViewEditable(for view: SetTimeView, isEditable: Bool) {
        switch isEditable {
        case true:
            view.backgroundRectangle.layer.borderColor = UIColor.mainPurple.cgColor
            view.backgroundRectangle.layer.borderWidth = recordStatus == .notSaved ? 1 : 0
            
        case false:
            view.backgroundRectangle.layer.borderWidth = 0
        }
    }
    
    private func setRecordCardTimeToView() {
        leftTimeView.date = recordCardTime.startString(status: fastState)
        rightTimeView.date = recordCardTime.endString(status: fastState)
    }
    
    private func showOrHideEditImage() {
        leftTimeView.editImageView.isHidden = !isStartTimeEditable
        rightTimeView.editImageView.isHidden = !isEndTimeEditable
    }
}

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
    
    let timerControlButton: TimerControlButton = {
        let button = TimerControlButton()
        
        return button
    }()
    
    lazy var planButton: FastPlanButton = {
        let button = FastPlanButton(fastPlan: timerSetting.plan, fastState: fastState)
        
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
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var fastControlButton: FastControlButton = {
        let button = FastControlButton()
        
        return button
    }()
    
    lazy var circularTimerView: CircularTimerView = {
        let view = CircularTimerView(fastState: fastState, timerSetting: timerSetting)
        
        return view
    }()
    
    lazy var recordTimeCardView: RecordTimeCardView = {
        let view = RecordTimeCardView(fastState: fastState, recordCardTime: recordCardTime, recordStatus: .notSaved, isStartTimeEditable: false, isEndTimeEditable: false)
        
        return view
    }()
    
    var fastState: FastState {
        didSet {
            configFastingStateToView()
        }
    }
    
    var timerSetting: TimerSetting {
        didSet {
            configTimerSettingToView()
        }
    }
    
    var recordCardTime: RecordCardTime {
        didSet {
            configRecordCardTimeToView()
        }
    }
    
    // MARK: - Initializer
    
    init(fastState: FastState, timerSetting: TimerSetting, recordCardTime: RecordCardTime) {
        self.fastState = fastState
        self.timerSetting = timerSetting
        self.recordCardTime = recordCardTime
        super.init(frame: .zero)
        
        configViewHierarchy()
        configLayoutConstraints()
        configFastingStateToView()
        configRecordCardTimeToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configTimerSettingToView() {
        circularTimerView.timerSetting = timerSetting
        planButton.fastPlan = timerSetting.plan
    }
    
    private func configFastingStateToView() {
        stateTitleLabel.text = fastState.stateTitle
        timeStatusLabel.text = fastState.timeStatus
        
        fastControlButton.fastState = fastState
        backgroundLayer.fastState = fastState
        timerControlButton.fastState = fastState
        planButton.fastState = fastState
        circularTimerView.fastState = fastState
        recordTimeCardView.fastState = fastState
    }
    
    private func configRecordCardTimeToView() {
        recordTimeCardView.recordCardTime = recordCardTime
    }
    
    private func configViewHierarchy() {
        let components = [timerControlButton, planButton, stateTitleLabel, circularTimerView, recordTimeCardView]
        components.forEach { item in
            addSubview(item)
        }
        
        circularTimerView.addSubview(counterStackView)
        circularTimerView.addSubview(fastControlButton)
    }
    
    private func configLayoutConstraints() {
        timerControlButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(Constants.Size.edgePadding)
        }
        planButton.snp.makeConstraints { make in
            make.top.equalTo(timerControlButton)
            make.trailing.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        stateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timerControlButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        circularTimerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Constants.Size.timer)
            make.height.equalTo(circularTimerView.snp.width)
            make.top.equalTo(stateTitleLabel.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        
        counterStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(circularTimerView.snp.centerY).offset(8)
        }
        fastControlButton.snp.makeConstraints { make in
            make.top.equalTo(counterStackView.snp.bottom).offset(16)
            make.centerX.equalTo(counterStackView)
            make.height.equalTo(36)
            make.width.equalToSuperview().multipliedBy(0.52)
        }
        
        recordTimeCardView.snp.makeConstraints { make in
            make.top.equalTo(circularTimerView.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.height.equalTo(112)
        }
    }
}

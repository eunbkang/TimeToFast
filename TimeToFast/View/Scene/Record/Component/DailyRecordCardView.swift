//
//  DailyRecordCardView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/17.
//

import UIKit

class DailyRecordCardView: BaseView {
    
    var fastingRecord: FastingRecordTable {
        didSet {
            configStateToView()
            configDataToView()
        }
    }
    
    var isRecordSaved: Bool {
        didSet {
            configStateToView()
            configDataToView()
        }
    }
    
    private let backgroundRect: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightGray
        view.layer.cornerRadius = .backgroundCornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let view = UIImageView()
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote, weight: .semibold))
        view.image = UIImage(systemName: "chevron.forward", withConfiguration: config)
        view.tintColor = .systemGray
        
        return view
    }()
    
    private let smallBackgroundRect: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        return view
    }()
    
    private let noRecordLabel: UILabel = {
        let label = UILabel()
        label.text = "No record"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray2
        
        return label
    }()
    
    private let trophyImageView: UIImageView = {
        let view = UIImageView()
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote))
        view.image = UIImage(systemName: "trophy.fill", withConfiguration: config)
        view.tintColor = .systemYellow
        
        return view
    }()
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "GOAL ACHIEVED"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var goalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trophyImageView, goalLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    private let fastingPlanLabelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .veryLightGray
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        
        return button
    }()
    
    private lazy var circularFastingHourView: CircularFastingHourView = {
        let view = CircularFastingHourView(fastingRecord: fastingRecord)
        
        return view
    }()
    
    private let fastingHourLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    private let hoursLabel: UILabel = {
        let label = UILabel()
        label.text = "hours"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var hourStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fastingHourLabel, hoursLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let startedLabel: UILabel = {
        let label = UILabel()
        label.text = "STARTED"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let startedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var startedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startedLabel, startedDateLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let endedLabel: UILabel = {
        let label = UILabel()
        label.text = "ENDED"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let endedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var endedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [endedLabel, endedDateLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startedStackView, endedStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var hourAndTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [circularFastingHourView, timeStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 32
        
        return stackView
    }()
    
    init(fastingRecord: FastingRecordTable, isRecordSaved: Bool) {
        self.fastingRecord = fastingRecord
        self.isRecordSaved = isRecordSaved
        super.init(frame: .zero)
        
        configDataToView()
        configStateToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configStateToView() {
        [chevronImageView, fastingPlanLabelButton, hourAndTimeStackView, hourStackView].forEach { item in
            item.isHidden = isRecordSaved ? false : true
        }
        
        goalStackView.isHidden = isRecordSaved && (fastingRecord.isGoalAchieved == true) ? false : true
        
        noRecordLabel.isHidden = isRecordSaved ? true : false
    }
    
    override func configViewHierarchy() {
        addSubview(backgroundRect)
        backgroundRect.addSubview(dateLabel)
        backgroundRect.addSubview(smallBackgroundRect)
        backgroundRect.addSubview(chevronImageView)
        
        [goalStackView, fastingPlanLabelButton, hourAndTimeStackView, hourStackView, noRecordLabel].forEach { component in
            smallBackgroundRect.addSubview(component)
        }
    }
    
    override func configLayoutConstraints() {
        backgroundRect.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.verticalEdges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(14)
        }
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        
        smallBackgroundRect.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        goalStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        fastingPlanLabelButton.snp.makeConstraints { make in
            make.centerY.equalTo(goalStackView.snp.centerY)
            make.trailing.equalToSuperview().inset(Constants.Size.edgePadding)
        }
        
        let timerSize = Constants.Size.FastingCircle.width
        
        circularFastingHourView.snp.makeConstraints { make in
            make.width.equalTo(timerSize)
            make.height.equalTo(circularFastingHourView.snp.width)
        }
        
        hourAndTimeStackView.snp.makeConstraints { make in
            make.top.equalTo(goalStackView.snp.bottom).offset(20)
            make.leading.equalTo(goalStackView.snp.leading).inset(4)
            make.trailing.equalToSuperview().inset(Constants.Size.edgePadding)
            make.bottom.equalToSuperview().inset(Constants.Size.edgePadding + 4)
        }
        
        hourStackView.snp.makeConstraints { make in
            make.center.equalTo(circularFastingHourView)
        }
        
        noRecordLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func configDataToView() {
        dateLabel.text = fastingRecord.date.dateMonthYear()
        fastingPlanLabelButton.setTitle(fastingRecord.makeFastingPlan().planButtonTitle, for: .normal)
        circularFastingHourView.fastingRecord = fastingRecord
        
        let fastingHours = fastingRecord.fastingEndTime.timeIntervalSince(fastingRecord.fastingStartTime) / 3600
        fastingHourLabel.text = String(format: "%.1f", fastingHours)
        
        startedDateLabel.text = fastingRecord.fastingStartTime.dateToFullTimeString()
        endedDateLabel.text = fastingRecord.fastingEndTime.dateToTimeOnlyString()
    }
}

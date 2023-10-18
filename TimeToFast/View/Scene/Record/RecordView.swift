//
//  RecordView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit

final class RecordView: BaseView {
    
    var fastingRecord: FastingRecordTable {
        didSet {
            configDataToView()
        }
    }
    
    var isRecordSaved: Bool {
        didSet {
            configDataToView()
        }
    }
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    private let contentView = UIView()
    
    let pastRecordsView = PastRecordsView()
    let thisWeekView = ThisWeekView()
    
    private lazy var dailyRecordCardView: DailyRecordCardView = {
        let view = DailyRecordCardView(fastingRecord: fastingRecord, isRecordSaved: isRecordSaved)
        
        return view
    }()

    private lazy var pastRecordsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [pastRecordsView, dailyRecordCardView])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 16

        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [thisWeekView, pastRecordsStackView])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 36

        return view
    }()
    
    init(fastingRecord: FastingRecordTable, isRecordSaved: Bool) {
        self.fastingRecord = fastingRecord
        self.isRecordSaved = isRecordSaved
        super.init(frame: .zero)
        
        configDataToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configDataToView() {
        dailyRecordCardView.fastingRecord = fastingRecord
        dailyRecordCardView.isRecordSaved = isRecordSaved
    }
    
    override func configViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    override func configLayoutConstraints() {
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalTo(self.safeAreaInsets)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        thisWeekView.snp.makeConstraints { make in
            make.height.equalTo(230)
        }
        pastRecordsView.snp.makeConstraints { make in
            make.height.equalTo(362)
        }
        dailyRecordCardView.snp.makeConstraints { make in
            make.height.equalTo(184)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
}

//
//  RecordView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit

final class RecordView: BaseView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    private let contentView = UIView()
    
    let pastRecordsView = PastRecordsView()
    let thisWeekView = ThisWeekView()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [thisWeekView, pastRecordsView])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 36

        return view
    }()
    
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
            make.height.equalTo(266)
        }
        pastRecordsView.snp.makeConstraints { make in
            make.height.equalTo(362)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

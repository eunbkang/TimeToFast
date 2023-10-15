//
//  PastRecordsView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit

final class PastRecordsView: BaseView {
    
    private let headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: .pastRecords)
        
        return view
    }()
    
    private let backgroundRect: BackShadowView = {
        let view = BackShadowView()
        
        return view
    }()
    
    override func configViewHierarchy() {
        addSubview(headerView)
        addSubview(backgroundRect)
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
    }
}

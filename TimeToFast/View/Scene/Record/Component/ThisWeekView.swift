//
//  ThisWeekView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/16.
//

import UIKit
import DGCharts

final class ThisWeekView: BaseView {
    
    private let headerView: PlanHeaderView = {
        let view = PlanHeaderView(type: .thisWeek)
        
        return view
    }()
    
    private let backgroundRect: BackShadowView = {
        let view = BackShadowView()
        
        return view
    }()
    
    let chartView: BarChartView = {
        let view = BarChartView()
        view.backgroundColor = .systemYellow
        
        return view
    }()
    
    override func configViewHierarchy() {
        addSubview(headerView)
        addSubview(backgroundRect)
        backgroundRect.addSubview(chartView)
    }
    
    override func configLayoutConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(28)
        }
        backgroundRect.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.height.equalTo(236)
        }
        chartView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview().inset(32)
        }
    }
}

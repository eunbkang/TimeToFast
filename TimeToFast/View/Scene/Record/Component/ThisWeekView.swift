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
        
        return view
    }()
    
    override func configViewHierarchy() {
        configChartStyle()
        
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
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configChartStyle() {
        chartView.backgroundColor = .white
        chartView.legend.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        
        chartView.noDataText = "There are no fasting records this week."
        chartView.noDataFont = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        chartView.noDataTextColor = .systemGray2
        
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = true
        chartView.xAxis.drawAxisLineEnabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .preferredFont(forTextStyle: .caption1)
        chartView.xAxis.labelTextColor = .systemGray
        
        chartView.animate(yAxisDuration: 0.5)
    }
}

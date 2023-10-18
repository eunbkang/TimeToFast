//
//  RecordViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit
import FSCalendar
import DGCharts

final class RecordViewController: BaseViewController {
    
    private let recordView = RecordView(fastingRecord: FastingRecordTable(date: Date(), fastingPlan: "16", fastingStartTime: Date()-3600*(9+17), fastingEndTime: Date()-3600*9, fastingDuration: 16.8, isGoalAchieved: true), isRecordSaved: false)
    private let viewMocel = RecordViewModel()
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Records"
        navigationItem.backButtonTitle = ""
        
        viewMocel.fetchFastingRecord()
        
        recordView.pastRecordsView.calendarView.delegate = self
        recordView.pastRecordsView.calendarView.dataSource = self
        
        configBarChart()
        setDataToRecordView(for: Date())
    }
    
    private func configBarChart() {
        recordView.thisWeekView.chartView.data = viewMocel.makeBarChartData()
        
        recordView.thisWeekView.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: viewMocel.makeThisWeekDay())
        recordView.thisWeekView.chartView.xAxis.setLabelCount(viewMocel.thisWeekData.count, force: false)
    }
    
    private func setDataToRecordView(for date: Date) {
        if let record = viewMocel.makeSelectedDateData(for: date) {
            recordView.fastingRecord = record
            recordView.isRecordSaved = true
        } else {
            recordView.isRecordSaved = false
        }
    }
}

extension RecordViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        setDataToRecordView(for: date)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        recordView.pastRecordsView.headerLabel.text = calendar.currentPage.yearAndMonth()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return date.isToday() ? .black : .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return date.isToday() ? .white : viewMocel.configCalendarDateType(for: date).titleColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return date.isToday() ? .white : viewMocel.configCalendarDateType(for: date).titleColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return date.isToday() ? .black : .clear
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return viewMocel.configCalendarDateType(for: date).title
    }
}

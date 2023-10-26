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
    private let viewModel = RecordViewModel()
    
    lazy var currentPage = recordView.pastRecordsView.calendarView.currentPage
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Localizing.Title.records
        navigationItem.backButtonTitle = ""
        
        bindViewComponents()
        viewModel.fetchFastingRecord()
        
        recordView.pastRecordsView.calendarView.delegate = self
        recordView.pastRecordsView.calendarView.dataSource = self
        
        configBarChart()
        addActionToMonthControlButtons()
        
        viewModel.makeSelectedDateData(for: Date())

    }
    
    @objc func monthControlButtonTapped(_ sender: UIButton) {
        moveMonthPage(isNext: sender == recordView.pastRecordsView.nextMonthButton)
    }
    
    private func bindViewComponents() {
        viewModel.seledtedDateRecord.bind { record in
            if let record {
                self.recordView.fastingRecord = record
                self.recordView.isRecordSaved = true
            } else {
                self.recordView.isRecordSaved = false
            }
        }
    }
    
    private func configBarChart() {
        recordView.thisWeekView.chartView.data = viewModel.makeBarChartData()
        
        recordView.thisWeekView.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: viewModel.makeThisWeekDay())
        recordView.thisWeekView.chartView.xAxis.setLabelCount(viewModel.thisWeekData.count, force: false)
    }
    
    private func moveMonthPage(isNext: Bool) {
        let amount = isNext ? 1 : -1
        currentPage = Calendar.current.date(byAdding: .month, value: amount, to: currentPage)!
        recordView.pastRecordsView.calendarView.setCurrentPage(currentPage, animated: true)
    }
    
    private func addActionToMonthControlButtons() {
        recordView.pastRecordsView.previousMonthButton.addTarget(self, action: #selector(monthControlButtonTapped), for: .touchUpInside)
        recordView.pastRecordsView.nextMonthButton.addTarget(self, action: #selector(monthControlButtonTapped), for: .touchUpInside)
    }
}

extension RecordViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.makeSelectedDateData(for: date)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        recordView.pastRecordsView.headerLabel.text = calendar.currentPage.yearAndMonth()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return date.isToday() ? .black : .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return date.isToday() ? .white : viewModel.configCalendarDateType(for: date).titleColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return date.isToday() ? .white : viewModel.configCalendarDateType(for: date).titleColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return date.isToday() ? .black : .clear
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return viewModel.configCalendarDateType(for: date).title
    }
}

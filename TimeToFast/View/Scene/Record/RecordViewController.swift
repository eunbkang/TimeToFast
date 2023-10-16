//
//  RecordViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit
import FSCalendar

final class RecordViewController: BaseViewController {
    
    private let recordView = RecordView()
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
    }
}

extension RecordViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        recordView.pastRecordsView.headerLabel.text = calendar.currentPage.yearAndMonth()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return date.isToday() ? .black : .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return date.isToday() ? .white : viewMocel.configCalendarDateColor(for: date).titleColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return date.isToday() ? .white : viewMocel.configCalendarDateColor(for: date).titleColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return date.isToday() ? .black : .clear
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return viewMocel.configCalendarDateColor(for: date).title
    }
}

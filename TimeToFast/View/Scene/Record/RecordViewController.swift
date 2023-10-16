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
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Records"
        navigationItem.backButtonTitle = ""
        
        recordView.pastRecordsView.calendarView.delegate = self
        recordView.pastRecordsView.calendarView.dataSource = self
    }
}

extension RecordViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        recordView.pastRecordsView.headerLabel.text = calendar.currentPage.yearAndMonth()
    }
    

}

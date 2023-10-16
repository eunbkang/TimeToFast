//
//  RecordViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/16.
//

import Foundation
import RealmSwift

final class RecordViewModel {
    
    private var recordResults: Results<FastingRecordTable>? {
        get {
            return repository?.recordList
        }
    }
    
    var recordList: Observable<[FastingRecordTable]> = Observable([])
    
    var recordedDates: Observable<[Date]> = Observable([])
    
    private let repository = FastingRecordRepository.shared
    
    func fetchFastingRecord() {
        repository?.recordList = repository?.fetch()
        
        guard let results = recordResults else { return }
        recordList.value = Array(results)
        configRecordedDates()
    }
    
    private func configRecordedDates() {
        recordedDates.value = recordList.value.map({ $0.date })
    }
    
    func configCalendarDateView(for date: Date) -> CalendarDate {
        if recordedDates.value.contains(date) {
            if recordList.value.contains(where: { $0.isGoalAchieved == true }) {
                return .success
            } else {
                return .failure
            }
        } else {
            return .nothing
        }
    }
    
    func configCalendarDateColor(for date: Date) -> CalendarDate {
        let record = recordList.value.first(where: { $0.date == date })

        if let record {
            switch record.isGoalAchieved {
            case true:
                return .success
            case false:
                return .failure
            }
        } else {
            return .nothing
        }
    }
}

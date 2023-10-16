//
//  RecordViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/16.
//

import Foundation
import RealmSwift
import DGCharts

final class RecordViewModel {
    
    private let repository = FastingRecordRepository.shared
    
    private var recordResults: Results<FastingRecordTable>? {
        get {
            return repository?.recordList
        }
    }
    
    var recordList: Observable<[FastingRecordTable]> = Observable([])
    
    var recordedDates: Observable<[Date]> = Observable([])
    
    let dayData = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    let hoursData: [Double] = [14.3, 15.7, 16.0, 16.3, 14.8, 16.8, 0]
    
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
    
    func makeBarChartData() -> BarChartData {
        let dataSet = BarChartDataSet(entries: makeChartDataEntry(data: hoursData), label: "fasting hour")
        
        return BarChartData(dataSet: dataSet)
    }
    
    private func makeChartDataEntry(data: [Double]) -> [BarChartDataEntry] {
        var barEntry: [BarChartDataEntry] = []
        
        for i in 0 ..< data.count {
            let item = BarChartDataEntry(x: Double(i), y: data[i])
            barEntry.append(item)
        }
        
        return barEntry
    }
}

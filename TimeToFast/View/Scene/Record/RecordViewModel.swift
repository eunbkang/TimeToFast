//
//  RecordViewModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/16.
//

import UIKit
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
    
    var thisWeek: [Date] = []
    var thisWeekData: [ThisWeekData] = []
    
    func fetchFastingRecord() {
        repository?.recordList = repository?.fetch()
        
        guard let results = recordResults else { return }
        recordList.value = Array(results)
        configRecordedDates()
        makeThisWeekDates()
        makeThisWeekData()
    }
    
    private func configRecordedDates() {
        recordedDates.value = recordList.value.map({ $0.date })
    }
    
    func configCalendarDateType(for date: Date) -> CalendarDate {
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
    
    func makeBarChartData() -> BarChartData? {
        if isThisWeekDataHasValue() {
            let dataSet = BarChartDataSet(entries: makeChartDataEntry(), label: "fasting hour")
            dataSet.setColors(isGoalAchievedFromHoursData(), alpha: 1.0)
            dataSet.valueFont = .preferredFont(forTextStyle: .caption1)
            dataSet.valueTextColor = .darkPurple
            
            let barChartData = BarChartData(dataSet: dataSet)
            barChartData.barWidth = 0.6
            
            return barChartData
        } else {
            return nil
        }
    }
    
    private func isThisWeekDataHasValue() -> Bool {
        let array = thisWeekData.map({ $0.value })
        
        return array.contains(where: { $0 > 0 }) ? true : false
    }
    
    private func makeChartDataEntry() -> [BarChartDataEntry] {
        var barEntry: [BarChartDataEntry] = []
        
        for i in 0 ..< thisWeekData.count {
            let item = BarChartDataEntry(x: Double(i), y: thisWeekData[i].value)
            barEntry.append(item)
        }
        
        return barEntry
    }
    
    private func isGoalAchievedFromHoursData() -> [UIColor] {
        var colors: [UIColor] = []
        
        for dayData in thisWeekData {
            let color: UIColor = dayData.value >= 16 ? .mainPurple : .lightPurple
            colors.append(color)
        }
        return colors
    }
    
    func makeThisWeekDay() -> [String] {
        return thisWeek.map { $0.dateToWeekday().uppercased() }
    }
    
    func makeThisWeekData() {
        thisWeekData.removeAll()
        
        for day in thisWeek {
            if let dayRecord = recordList.value.first(where: { $0.date == day }) {
                let dayData = ThisWeekData(day: day.dateToWeekday(), value: dayRecord.fastingDuration / 3600, isGoalAchieved: dayRecord.isGoalAchieved)
                thisWeekData.append(dayData)
                
            } else {
                let dayData = ThisWeekData(day: day.dateToWeekday(), value: 0.0, isGoalAchieved: false)
                thisWeekData.append(dayData)
            }
        }
    }
    
    private func makeThisWeekDates() {
        let calendar = Calendar.current
        let today = Date().makeDateOnlyDate()
        
        for i in 0...6 {
            if let date = calendar.date(byAdding: .day, value: i-6, to: today) {
                thisWeek.append(date)
            }
        }
    }
}

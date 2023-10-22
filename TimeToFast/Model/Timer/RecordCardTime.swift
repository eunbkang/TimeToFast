//
//  RecordCardTime.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/12.
//

import Foundation

struct RecordCardTime {
    var startTime: Date
    var endTime: Date
    
    func startString(status: FastState) -> String {
        if status == .idle {
            return startTime.dateToTimeOnlyString()
            
        } else {
            return startTime.dateToSetTimeString()
        }
    }
    
    func endString(status: FastState) -> String {
        if status == .idle {
            return endTime.dateToTimeOnlyString()
            
        } else {
            return endTime.dateToSetTimeString()
        }
    }
}

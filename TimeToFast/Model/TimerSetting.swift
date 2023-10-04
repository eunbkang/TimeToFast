//
//  Timer.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/28.
//

import Foundation

struct TimerSetting {
    var fastStartTime: Date
    var fastEndTime: Date? {
        return Calendar.current.date(byAdding: .hour, value: 16, to: fastStartTime)
    }
    
    var fastStartAngle: CGFloat {
        return fastStartTime.dateToAngle()
    }
    
    var fastEndAngle: CGFloat {
        guard let fastEndTime = fastEndTime else { return 0 }
        return fastEndTime.dateToAngle()
    }
}

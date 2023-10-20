//
//  Days.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import Foundation

enum Days {
    case mon, tue, wed, thu, fri, sat, sun
    
    var name: String {
        switch self {
        case .mon: return "MON"
        case .tue: return "TUE"
        case .wed: return "WED"
        case .thu: return "THU"
        case .fri: return "FRI"
        case .sat: return "SAT"
        case .sun: return "SUN"
        }
    }
}

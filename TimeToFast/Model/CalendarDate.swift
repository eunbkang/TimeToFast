//
//  CalendarDate.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/16.
//

import UIKit

enum CalendarDate {
    case nothing
    case success
    case failure
    
    var fillColor: UIColor {
        switch self {
        case .nothing:
            return .clear
        case .success:
            return .mainPurple
        case .failure:
            return .lightPurple
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .nothing:
            return .black
        case .success:
            return .mainPurple
        case .failure:
            return .lightPurple
        }
    }
    
    var title: String? {
        switch self {
        case .nothing:
            return nil
        case .success, .failure:
            return "●"
        }
    }
}

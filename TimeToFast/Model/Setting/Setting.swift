//
//  Setting.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/10.
//

import Foundation

enum Setting: CaseIterable {
    case notification
    
    var image: String {
        switch self {
        case .notification:
            return "bell.badge"
        }
    }
    
    var title: String {
        switch self {
        case .notification:
            return Localizing.Setting.notification
        }
    }
}

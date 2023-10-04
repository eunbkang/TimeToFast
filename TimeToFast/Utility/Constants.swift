//
//  Constants.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit

enum Constants {
    
    enum FastPlan {
        static let fast1410 = "14:10"
        static let fast1608 = "16:8"
        static let fast1806 = "18:6"
        static let fast2004 = "20:4"
    }
    
    enum ShowTime {
        static let show = "SHOW TIME"
        static let hide = "REMOVE TIME"
    }
    
    enum FastControl {
        static let start = "Start Fast"
        static let end = "End Fast"
    }
    
    enum StateTitle {
        static let idle = "It's time to fast!"
        static let fasting = "You're fasting!"
        static let eating = "You're eating!"
    }
    
    enum TimeStatus {
        static let eating = "FASTING STARTS IN"
        static let base = "REMAINING TIME"
    }
    
    enum Padding {
        static let edge: CGFloat = 16
    }
    
    enum Corner {
        static let button: CGFloat = 12
    }
    
    enum Color {
        static let mainPurple = UIColor(hex: "8C02E0")!
        static let lightPurple = UIColor(hex: "E2BDF9")!
        static let darkPurple = UIColor(hex: "8C02E0")!
        
        static let mainGreen = UIColor(hex: "A6E002")!
        static let lightGreen = UIColor(hex: "E8F9B8")!
        static let darkGreen = UIColor(hex: "83B000")!
        
        static let veryLightGray = UIColor(hex: "F5F5F5")!
        static let darkGray = UIColor(hex: "787878")!
    }
}

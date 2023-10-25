//
//  CircularDayButton.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

enum CircularDayStatus {
    case selected
    case normal
}

class CircularDayButton: UIButton {
    
    var day: Days
    var status: CircularDayStatus {
        didSet {
            configView()
        }
    }
    
    init(day: Days, status: CircularDayStatus) {
        self.day = day
        self.status = status
        super.init(frame: .zero)
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        setTitle(day.name, for: .normal)
        setTitleColor(.black, for: .normal)
        
        switch status {
        case .selected:
            backgroundColor = .lightPurple
            titleLabel?.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
            
        case .normal:
            backgroundColor = .white
            titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        }
    }
}

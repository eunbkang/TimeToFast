//
//  FastControlButton.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/08.
//

import UIKit

class FastControlButton: UIButton {
    
    var fastState: FastState {
        didSet {
            configView()
        }
    }
    
    init(fastState: FastState = .idle) {
        self.fastState = fastState
        super.init(frame: .zero)
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        setTitle(fastState.fastControl, for: .normal)
        setTitleColor(.black, for: .normal)
        setTitleColor(.systemGray, for: .disabled)
        
        layer.cornerRadius = .buttonCornerRadius
        titleLabel?.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        
        switch fastState {
        case .idle, .fastingBreak:
            backgroundColor = Constants.Color.veryLightGray
            
        case .fasting, .eating, .fastingEarly:
            backgroundColor = .white.withAlphaComponent(0.5)
        }
        
//        isEnabled = fastState == .idle ? false : true
        switch fastState {
        case .fasting, .fastingBreak, .fastingEarly:
            isEnabled = true
        default:
            isEnabled = false
        }
    }
}

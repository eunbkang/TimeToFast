//
//  BackgroundGradientLayer.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import UIKit

class BackgroundGradientLayer: CAGradientLayer {
    
    var fastState: FastState = .idle {
        didSet {
            configView()
        }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        self.locations = [0.25]
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 0.5, y: 1.25)
        
        switch fastState {
        case .idle, .fastingBreak:
            self.colors = [UIColor.white.cgColor]
            
        case .fasting, .fastingEarly:
            self.colors = [Constants.Color.lightPurple.withAlphaComponent(0.75).cgColor, Constants.Color.lightGreen.withAlphaComponent(0.75).cgColor]
            
        case .eating:
            self.colors = [Constants.Color.lightGreen.withAlphaComponent(0.75).cgColor, Constants.Color.lightPurple.withAlphaComponent(0.75).cgColor]
        }
    }
}

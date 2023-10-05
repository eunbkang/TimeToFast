//
//  FastPlanButton.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import UIKit

class FastPlanButton: UIButton {
    
    var fastPlan: FastPlanType = .fast1410 {
        didSet {
            configView()
        }
    }
    
    var fastState: FastState = .idle {
        didSet {
            configView()
        }
    }
    
    init(fastPlan: FastPlanType = .fast1410, fastState: FastState = .idle) {
        super.init(frame: .zero)
        
        self.fastPlan = fastPlan
        self.fastState = fastState
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(fastPlan.planButtonTitle)
        titleAttr.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        config.attributedTitle = titleAttr
                
        config.image = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote)))
        config.imagePlacement = .trailing
        config.imagePadding = 4
        
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
        
        if fastState == .idle {
            config.background.backgroundColor = Constants.Color.veryLightGray
        } else {
            config.background.backgroundColor = .white.withAlphaComponent(0.5)
        }
        
        self.configuration = config
    }
}

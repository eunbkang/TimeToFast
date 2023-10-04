//
//  TimeToggleButton.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import UIKit

class TimeToggleButton: UIButton {
    
    var status: ShowTimeStatus = .showing {
        didSet {
            configView()
        }
    }
    
    var fastState: FastState = .idle {
        didSet {
            configView()
        }
    }
    
    init(status: ShowTimeStatus = .showing, fastState: FastState = .idle) {
        super.init(frame: .zero)
        
        self.status = status
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(status.title)
        titleAttr.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
        config.attributedTitle = titleAttr
                
        config.image = UIImage(systemName: "clock.fill", withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote)))
        config.imagePlacement = .leading
        config.imagePadding = 4
        
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
        
        if fastState == .idle {
            switch status {
            case .showing:
                config.baseForegroundColor = .white
                config.background.backgroundColor = Constants.Color.darkGray
            case .hiding:
                config.baseForegroundColor = .black
                config.background.backgroundColor = Constants.Color.veryLightGray
            }
        } else {
            switch status {
            case .showing:
                config.baseForegroundColor = .white
                config.background.backgroundColor = .black.withAlphaComponent(0.5)
                
            case .hiding:
                config.baseForegroundColor = .black
                config.background.backgroundColor = .white.withAlphaComponent(0.5)
            }
        }
        
        self.configuration = config
    }
}

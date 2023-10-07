//
//  TimeToggleButton.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/27.
//

import UIKit

class TimerControlButton: UIButton {
    
    var status: TimerStatus {
        return fastState == .idle ? .stopped : .playing
    }
    
    var fastState: FastState = .idle {
        didSet {
            configView()
        }
    }
    
    init(fastState: FastState = .idle) {
        super.init(frame: .zero)
        
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
                
        config.image = UIImage(systemName: status.image, withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote)))
        config.imagePlacement = .leading
        config.imagePadding = 4
        
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
        
        if fastState == .idle {
            config.baseForegroundColor = .white
            config.background.backgroundColor = .black

        } else {
            config.baseForegroundColor = .black
            config.background.backgroundColor = .white.withAlphaComponent(0.5)
        }
        
        self.configuration = config
    }
}

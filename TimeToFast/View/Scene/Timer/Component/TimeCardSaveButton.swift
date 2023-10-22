//
//  TimeCardSaveButton.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/12.
//

import UIKit

enum RecordStatus {
    case notSaved
    case saved
    
    var saveButtonTitle: String {
        switch self {
        case .notSaved: return Localizing.Button.saveUpper
        case .saved: return Localizing.Button.savedUpper
        }
    }
}

class TimeCardSaveButton: UIButton {
    
    var status: RecordStatus {
        didSet {
            configView()
        }
    }
    
    init(status: RecordStatus) {
        self.status = status
        super.init(frame: .zero)
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(status.saveButtonTitle)
        titleAttr.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        config.attributedTitle = titleAttr
        
        config.cornerStyle = .fixed
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        
        switch status {
        case .notSaved:
            config.baseForegroundColor = .white
            config.background.backgroundColor = .black
            
        case .saved:
            config.image = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote)))
            config.imagePlacement = .trailing
            config.imagePadding = 4
            
            config.baseForegroundColor = .darkPurple
            config.background.backgroundColor = .clear
        }
        
        self.configuration = config
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}

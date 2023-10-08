//
//  WeeklyCollectionViewCell.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class WeeklyTableViewCell: BaseTableViewCell {
    
    private let backgroundRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightGray
        view.layer.cornerRadius = Constants.Size.backgroundCorner
        view.clipsToBounds = true
        
        return view
    }()
    
    override func configViewComponents() {
        
    }
    
    override func configLayoutConstraints() {
        
    }
}

//
//  BaseTableViewCell.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configViewComponents()
        configLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViewComponents() { }
    
    func configLayoutConstraints() { }
}

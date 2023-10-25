//
//  BackShadowView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit

class BackShadowView: BaseView {
    
    private let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.masksToBounds = false
        
        view.layer.cornerRadius = Constants.Size.backgroundCorner
        
        return view
    }()
    
    override func configViewHierarchy() {
        addSubview(shadowView)
    }
    
    override func configLayoutConstraints() {
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

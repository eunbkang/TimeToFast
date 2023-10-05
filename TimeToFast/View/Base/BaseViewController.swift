//
//  BaseViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configViewHierarchy()
        configLayoutConstraints()
    }
    
    func configViewHierarchy() { }
    
    func configLayoutConstraints() { }
}

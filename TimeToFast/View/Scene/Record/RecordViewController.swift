//
//  RecordViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/15.
//

import UIKit

final class RecordViewController: BaseViewController {
    
    private let recordView = RecordView()
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Records"
        navigationItem.backButtonTitle = ""
    }
    
}

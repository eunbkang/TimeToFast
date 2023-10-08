//
//  PlanViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/08.
//

import UIKit

final class PlanViewController: BaseViewController {
    
    private let planView = PlanView()
    
    override func loadView() {
        view = planView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Plan"
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    override func configViewHierarchy() {
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem = dismissButton
    }
    
}

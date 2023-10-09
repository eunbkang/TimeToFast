//
//  PlanViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/08.
//

import UIKit

final class PlanViewController: BaseViewController, SetTimeDelegate{
    
    private let viewModel = PlanViewModel()
    
    private lazy var planView = PlanView(planSetting: viewModel.planSetting.value)
    
    override func loadView() {
        view = planView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Plan"
        bindViewComponents()
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func eatingFromTimeViewTapped() {
        let vc = EditStartedTimeViewController()
        vc.type = .planEatingFromTime
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    override func configViewHierarchy() {
        let eatingFromTimeTapGesture = UITapGestureRecognizer(target: self, action: #selector(eatingFromTimeViewTapped))
        planView.eatingPeriodView.fromTimeView.addGestureRecognizer(eatingFromTimeTapGesture)
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    private func bindViewComponents() {
        viewModel.planSetting.bind { plan in
            self.planView.planSetting = plan
        }
    }
    
    func didReceiveStartedTime(time: Date) {
        viewModel.planSetting.value.eatingStartTime = time
    }
}

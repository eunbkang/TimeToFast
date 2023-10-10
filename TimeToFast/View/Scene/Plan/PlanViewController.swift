//
//  PlanViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/08.
//

import UIKit

final class PlanViewController: BaseViewController {
    
    private let viewModel = PlanViewModel()
    
    private lazy var planView = PlanView(planSetting: viewModel.planSetting.value)
    
    weak var delegate: SetPlanDelegate?
    
    override func loadView() {
        view = planView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Plan"
        navigationItem.backButtonTitle = ""
        
        bindViewComponents()
        viewModel.getStoredSetting()
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func fastPlanViewTapped() {
        let vc = ChooseFastingPlanViewController()
        vc.planSetting = viewModel.planSetting.value
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func eatingFromTimeViewTapped() {
        let vc = EditStartedTimeViewController()
        vc.type = .planEatingFromTime
        vc.timePicker.date = viewModel.planSetting.value.eatingStartTime
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func saveButtonTapped() {
        viewModel.savePlan()
        dismiss(animated: true)
        
        delegate?.didSavedPlanSetting()
    }
    
    override func configViewHierarchy() {
        let fastPlanTapGesture = UITapGestureRecognizer(target: self, action: #selector(fastPlanViewTapped))
        planView.fastingPlanView.backgroundRectangle.addGestureRecognizer(fastPlanTapGesture)
        
        let eatingFromTimeTapGesture = UITapGestureRecognizer(target: self, action: #selector(eatingFromTimeViewTapped))
        planView.eatingPeriodView.fromTimeView.addGestureRecognizer(eatingFromTimeTapGesture)
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem = dismissButton
        
        planView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewComponents() {
        viewModel.planSetting.bind { plan in
            self.planView.planSetting = plan
        }
    }
}

extension PlanViewController: SetTimeDelegate {
    func didReceiveStartedTime(time: Date) {
        viewModel.planSetting.value.eatingStartTime = time
    }
}

extension PlanViewController: SelectedFastingPlanDelegate {
    func didSelectedFastingPlan(plan: FastingPlan) {
        viewModel.planSetting.value.plan = plan
    }
}

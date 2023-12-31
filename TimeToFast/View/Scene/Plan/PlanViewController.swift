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
        
        title = Localizing.Title.editPlan
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
        let alert = UIAlertController(title: Constants.Alert.EditPlan.title, message: Constants.Alert.EditPlan.message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { _ in
            self.viewModel.savePlan()
            self.delegate?.didSavedPlanSetting()
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
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
    func didReceiveEditedTime(type: EditTimeType, time: Date) {
        viewModel.planSetting.value.eatingStartTime = time
    }
}

extension PlanViewController: SelectedFastingPlanDelegate {
    func didSelectedFastingPlan(plan: FastingPlan) {
        viewModel.planSetting.value.plan = plan
    }
}

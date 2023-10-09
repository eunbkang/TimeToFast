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
        
//        planView.planTableView.delegate = self
//        planView.planTableView.dataSource = self
//        planView.planTableView.separatorStyle = .none
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    override func configViewHierarchy() {
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem = dismissButton
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
//
//extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return EditPlanHeaderType.allCases.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch indexPath.section {
//        case EditPlanHeaderType.weeklySchedule.rawValue:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyTableViewCell.description()) as? WeeklyTableViewCell else { return UITableViewCell() }
//
//            return cell
//
//        case EditPlanHeaderType.fastingPlan.rawValue:
//            return UITableViewCell()
//
//        case EditPlanHeaderType.eatingPeriod.rawValue:
//            return UITableViewCell()
//
//        default:
//            return UITableViewCell()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlanTableHeaderView.description()) as? PlanTableHeaderView else { return UIView() }
//
//        header.type = EditPlanHeaderType.allCases[section]
//
//        return header
//    }
//}

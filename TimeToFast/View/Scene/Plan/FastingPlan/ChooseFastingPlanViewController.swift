//
//  ChooseFastingPlanViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class ChooseFastingPlanViewController: BaseViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FastingPlanTableViewCell.self, forCellReuseIdentifier: FastingPlanTableViewCell.description())
        tableView.rowHeight = 88
        
        return tableView
    }()
    
    var planSetting: PlanSetting?
    
    weak var delegate: SelectedFastingPlanDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fasting Plan"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func configViewHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configLayoutConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChooseFastingPlanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FastingPlan.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FastingPlanTableViewCell.description()) as? FastingPlanTableViewCell else { return UITableViewCell()}
        
        cell.configPlanToView(plan: FastingPlan.allCases[indexPath.row], selectedPlan: planSetting?.plan)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FastingPlanTableViewCell.description()) as? FastingPlanTableViewCell else { return }
        
        let selectedPlan = FastingPlan.allCases[indexPath.row]
        delegate?.didSelectedFastingPlan(plan: selectedPlan)
        planSetting?.plan = selectedPlan
        tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
}

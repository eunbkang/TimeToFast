//
//  PlanView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class PlanView: BaseView {

    let planTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(PlanTableHeaderView.self, forHeaderFooterViewReuseIdentifier: PlanTableHeaderView.description())
        tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: WeeklyTableViewCell.description())
        
        return tableView
    }()
    
    override func configViewHierarchy() {
        addSubview(planTableView)
    }
    
    override func configLayoutConstraints() {
        planTableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

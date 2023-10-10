//
//  SettingViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/10.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    private let settingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.description())
        
        tableView.backgroundColor = .clear
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.10
        tableView.layer.shadowRadius = 10
        tableView.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableView.layer.masksToBounds = false
        
        tableView.rowHeight = 44
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    override func configViewHierarchy() {
        view.addSubview(settingTableView)
    }
    
    override func configLayoutConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindViewComponents() {
        
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.description()) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.setSettingContentToView(type: Setting.allCases[indexPath.row])
        
        return cell
    }
}

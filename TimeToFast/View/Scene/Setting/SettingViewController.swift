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
    
    private let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        viewModel.getStoredSetting()
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
    
    @objc func toggleSwitchValueChanged(_ sender: UISwitch) {
        viewModel.saveToggleSwitchValue(index: sender.tag, isOn: sender.isOn)
    }
    
    private func configToggleSwitchIsOn(index: Int) -> Bool {
        return viewModel.configToggleSwitchIsOn(index: index)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.description()) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.setSettingContentToView(type: Setting.allCases[indexPath.row])
        
        cell.toggleSwitch.tag = indexPath.item
        cell.toggleSwitch.addTarget(self, action: #selector(toggleSwitchValueChanged), for: .valueChanged)
        cell.toggleSwitch.isOn = configToggleSwitchIsOn(index: indexPath.item)
        
        return cell
    }
}

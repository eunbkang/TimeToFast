//
//  SettingTableViewCell.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/10.
//

import UIKit

final class SettingTableViewCell: BaseTableViewCell {
    
    private let settingImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black

        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black

        return label
    }()
    
    private lazy var toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = .mainPurple
        
        return toggleSwitch
    }()
    
    override func configViewComponents() {
        contentView.addSubview(settingImageView)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(toggleSwitch)
    }
    
    override func configLayoutConstraints() {
        
        settingImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Size.edgePadding)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(settingImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.Size.edgePadding)
            make.centerY.equalToSuperview()
        }
    }
    
    func setSettingContentToView(type: Setting) {
        settingImageView.image = UIImage(systemName: type.image, withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .body)))
        titleLabel.text = type.title
    }
}

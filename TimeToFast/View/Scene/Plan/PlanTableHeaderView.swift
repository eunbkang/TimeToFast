//
//  PlanTableHeaderView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class PlanTableHeaderView: UITableViewHeaderFooterView {
    
    var type: EditPlanHeaderType = .weeklySchedule
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        view.image = UIImage(systemName: type.header.image, withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote)))
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = type.header.title
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configViewComponents()
        configLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViewComponents() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func configLayoutConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(28)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
        }
    }
}

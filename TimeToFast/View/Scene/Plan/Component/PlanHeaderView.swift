//
//  PlanHeaderView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/09.
//

import UIKit

final class PlanHeaderView: UIView {
    
    var type: EditPlanHeaderType {
        didSet {
            configTypeToView()
        }
    }
    
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
    
    init(type: EditPlanHeaderType) {
        self.type = type
        super.init(frame: .zero)
    
        configViewComponents()
        configLayoutConstraints()
        configTypeToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configTypeToView() {
        imageView.image = UIImage(systemName: type.header.image, withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote)))
        titleLabel.text = type.header.title
    }
    
    private func configViewComponents() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    private func configLayoutConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
        }
    }
}

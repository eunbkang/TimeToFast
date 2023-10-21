//
//  SetTimeView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import UIKit

enum SetTimeViewType {
    case started
    case goal
}

class SetTimeView: UIView {
    
//    var viewType: SetTimeViewType
    var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    var date: String {
        didSet {
            dateLabel.text = date
        }
    }
    
    var fastState: FastState {
        didSet {
            configStateToView()
        }
    }
    
    lazy var backgroundRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = .buttonCornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .systemGray
        label.text = title
        
        return label
    }()
    
    let editImageView: UIImageView = {
        let view = UIImageView()
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .footnote))
        view.image = UIImage(systemName: "pencil", withConfiguration: config)
        view.tintColor = .systemGray
        
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .black
        label.text = date
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    init(title: String, date: String, fastState: FastState) {
//        self.viewType = viewType
        self.title = title
        self.date = date
        self.fastState = fastState
        super.init(frame: .zero)
        
        configViewHierarchy()
        configLayoutConstraints()
        configStateToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configStateToView() {
        backgroundRectangle.backgroundColor = fastState == .idle || fastState == .fastingBreak ? .white : .white.withAlphaComponent(0.75)
    }
    
    private func configViewHierarchy() {
        addSubview(backgroundRectangle)
        addSubview(labelStackView)
        addSubview(editImageView)
    }
    
    private func configLayoutConstraints() {
        backgroundRectangle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labelStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        editImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
    }
}

//
//  EditStartedTimeViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import UIKit

enum EditTimeType {
    case fastingStartedTime
    case planEatingFromTime
}

final class EditStartedTimeViewController: BaseViewController {
    
    var type: EditTimeType = .fastingStartedTime
    
    weak var delegate: SetTimeDelegate?
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.minuteInterval = 5
        picker.frame.size = CGSize(width: 0, height: 300)
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    private lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(saveButtonTapped))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case .fastingStartedTime:
            title = "Edit Started Time"
        case .planEatingFromTime:
            title = "Eating From"
        }
    }
    
    override func configViewHierarchy() {
        view.addSubview(timePicker)
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func configLayoutConstraints() {
        timePicker.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.Size.edgePadding)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.Size.edgePadding)
        }
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        delegate?.didReceiveStartedTime(time: timePicker.date)
        
        dismiss(animated: true)
    }
}

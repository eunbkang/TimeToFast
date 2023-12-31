//
//  EditStartedTimeViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/05.
//

import UIKit

enum EditTimeType {
    case fastingStartedTime
    case fastingEndedTime
    case planEatingFromTime
}

final class EditStartedTimeViewController: BaseViewController {
    
    var type: EditTimeType = .fastingStartedTime
    
    weak var delegate: SetTimeDelegate?
    
    var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
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
        
        configPickerSettingPerType()
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
        delegate?.didReceiveEditedTime(type: type, time: timePicker.date)
        
        dismiss(animated: true)
    }
    
    private func configPickerSettingPerType() {
        let current = Date()
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: current)
        
        switch type {
        case .fastingStartedTime:
            title = Localizing.EditTime.editStartedTime
            timePicker.datePickerMode = .dateAndTime
            timePicker.minuteInterval = 1
            timePicker.maximumDate = current
            timePicker.minimumDate = minDate
            
        case .fastingEndedTime:
            title = Localizing.EditTime.editEndedTime
            timePicker.datePickerMode = .dateAndTime
            timePicker.minuteInterval = 1
            timePicker.maximumDate = current
            timePicker.minimumDate = minDate
            
        case .planEatingFromTime:
            title = Localizing.EditTime.eatingFrom
            timePicker.datePickerMode = .time
            timePicker.minuteInterval = 5
        }
    }
}

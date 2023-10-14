//
//  TimerViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit
import SnapKit

final class TimerViewController: BaseViewController {
    
    private lazy var timerView = TimerView(fastState: viewModel.fastState.value, timerSetting: viewModel.timerSetting.value, recordCardTime: viewModel.recordCardTime.value)
    
    private let viewModel = TimerViewModel()
    private let repository = FastingRecordRepository.shared
    
    override func loadView() {
        view = timerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        bindViewComponents()
        viewModel.getStoredSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timerView.backgroundLayer.frame = view.bounds
        view.layer.insertSublayer(timerView.backgroundLayer, at: 0)
    }
    
    override func configViewHierarchy() {
        timerView.planButton.addTarget(self, action: #selector(planButtonTapped), for: .touchUpInside)
        
        timerView.timerControlButton.addTarget(self, action: #selector(timerControlButtonTapped), for: .touchUpInside)
        
        timerView.fastControlButton.addTarget(self, action: #selector(fastControlButtonTapped), for: .touchUpInside)
        
        timerView.recordTimeCardView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let recordButton = UIBarButtonItem(image: UIImage(systemName: "chart.bar.xaxis"), style: .plain, target: self, action: #selector(recordButtonTapped))
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.leftBarButtonItem = recordButton
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func planButtonTapped() {
        let vc = PlanViewController()
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func timerControlButtonTapped() {
        viewModel.controlTimer()
    }
    
    @objc func recordButtonTapped() {
        
    }
    
    @objc func settingButtonTapped() {
        let vc = SettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func leftTimeViewTapped() {
        let vc = EditStartedTimeViewController()
        vc.type = .fastingStartedTime
        vc.timePicker.date = viewModel.timerSetting.value.fastStartTime
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func rightTimeViewTapped() {
        let vc = EditStartedTimeViewController()
        vc.type = .fastingEndedTime
        vc.timePicker.date = viewModel.timerSetting.value.fastEndTime
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func fastControlButtonTapped() {
        
    }
    
    @objc func saveButtonTapped() {
        let alert = UIAlertController(title: Constants.Alert.SaveRecord.title, message: Constants.Alert.SaveRecord.message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { _ in
            do {
                try self.viewModel.saveNewFastingRecord()
                self.showAlert(title: "Saved Successfully.", message: nil)
            } catch {
                self.showAlert(title: "Error", message: "Failed to save the record.")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okay)
        present(alert, animated: true)
    }
    
    private func setStartTimeViewTapGestures(isEditable: Bool) {
        let leftTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftTimeViewTapped))
        
        if isEditable {
            timerView.recordTimeCardView.leftTimeView.addGestureRecognizer(leftTapGestureRecognizer)
        } else {
            timerView.recordTimeCardView.leftTimeView.gestureRecognizers?.removeAll()
        }
    }
    
    private func setEndTimeViewTapGestures(isEditable: Bool) {
        let rightTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightTimeViewTapped))
        
        if isEditable {
            timerView.recordTimeCardView.rightTimeView.addGestureRecognizer(rightTapGestureRecognizer)
        } else {
            timerView.recordTimeCardView.rightTimeView.gestureRecognizers?.removeAll()
        }
    }
    
    private func bindViewComponents() {
        viewModel.fastState.bind { fastState in
            self.timerView.fastState = fastState
            self.viewModel.configTimeViewEditable()
            self.viewModel.configRecordCardTime()
        }
        
        viewModel.stateTitle.bind { state in
            self.timerView.stateTitleLabel.text = state
        }
        
        viewModel.timeCounter.bind { time in
            self.timerView.timeCounterLabel.text = time
        }
        
        viewModel.timerSetting.bind { timer in
            self.timerView.timerSetting = timer
        }
        
        viewModel.recordCardTime.bind { time in
            self.timerView.recordCardTime = time
        }
        
        viewModel.isStartTimeEditable.bind { editable in
            self.timerView.recordTimeCardView.isStartTimeEditable = editable
            self.setStartTimeViewTapGestures(isEditable: editable)
        }
        
        viewModel.isEndTimeEditable.bind { editable in
            self.timerView.recordTimeCardView.isEndTimeEditable = editable
            self.setEndTimeViewTapGestures(isEditable: editable)
        }
    }
}

extension TimerViewController: SetTimeDelegate {
    func didReceiveEditedTime(type: EditTimeType, time: Date) {
        viewModel.saveEditedTimeToUserDefaults(type: type, time: time)
    }
}

extension TimerViewController: SetPlanDelegate {
    func didSavedPlanSetting() {
        viewModel.getStoredSetting()
    }
}

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
        showAlertStartTimer()
    }
    
    @objc func recordButtonTapped() {
        let vc = RecordViewController()
        
        navigationController?.pushViewController(vc, animated: true)
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
        showAlertFastControlButton()
    }
    
    @objc func saveButtonTapped() {
        let alert = UIAlertController(title: Constants.Alert.SaveRecord.title, message: Constants.Alert.SaveRecord.message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { _ in
            if let existingRecord = self.viewModel.checkIsNewRecordToday() {
                self.showAlertTodaysRecordExists(isEarly: false, record: existingRecord)
            } else {
                do {
                    try self.viewModel.saveNewFastingRecord()
                    self.viewModel.getStoredSetting()
                    self.showAlert(title: Constants.Alert.SaveSucceed.title, message: nil)
                } catch {
                    self.showAlert(title: Constants.Alert.SaveError.title, message: Constants.Alert.SaveError.message)
                }
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
    
    private func showAlertTodaysRecordExists(isEarly: Bool, record: FastingRecordTable) {
        let message = viewModel.makeTodaysRecordExistsAlertMessage(record: record)
        
        let alert = UIAlertController(title: Constants.Alert.TodaysRecordExists.title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Replace", style: .default) { _ in
            do {
                try self.viewModel.updateTodaysRecord(isEarly: isEarly)
                self.viewModel.getStoredSetting()
                self.showAlert(title: Constants.Alert.SaveSucceed.title, message: nil)
            } catch {
                self.showAlert(title: Constants.Alert.SaveError.title, message: Constants.Alert.SaveError.message)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func showAlertStartTimer() {
        let alertTitle = viewModel.fastState.value == .idle ? Constants.Alert.TimerStart.title : Constants.Alert.TimerStop.title
        let alertMessage = viewModel.fastState.value == .idle ? viewModel.makeTimerStartAlertMessage() : Constants.Alert.TimerStop.message
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Yes", style: .default) { _ in
            self.viewModel.controlTimer()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func showAlertFastControlButton() {
        switch viewModel.fastState.value {
        case .fasting, .fastingEarly:
            configBreakFastAlert()
            
        case .fastingBreak:
            configResumeFastinglert()
            
        case .eating:
            configFastingEarlyAlert()
            
        case .idle:
            break
        }
    }
    
    private func showAlert(title: String, message: String, action: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Yes", style: .default, handler: action)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func configBreakFastAlert() {
        let title = Constants.Alert.BreakFast.title
        let message = Constants.Alert.BreakFast.message
        
        showAlert(title: title, message: message) { _ in
            self.viewModel.breakFasting()
        }
    }
    
    private func configResumeFastinglert() {
        let title = Constants.Alert.ResumeFast.title
        let message = Constants.Alert.ResumeFast.message
        
        showAlert(title: title, message: message) { _ in
            self.viewModel.resumeFasting()
        }
    }
    
    private func configFastingEarlyAlert() {
        let title = Constants.Alert.StartEarly.title
        let message = Constants.Alert.StartEarly.message
        
        showAlert(title: title, message: message) { _ in
            self.viewModel.startFastingEarly()
        }
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
            self.viewModel.configTimerSetting()
            self.viewModel.configRecordCardTime()
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
        
        viewModel.recordStatus.bind { status in
            self.timerView.recordTimeCardView.recordStatus = status
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

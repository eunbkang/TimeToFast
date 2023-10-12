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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftTimeViewTapped))
//        timerView.startedTimeView.addGestureRecognizer(tapGestureRecognizer)
        
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
    
    @objc func fastControlButtonTapped() {
        
    }
    
    private func bindViewComponents() {
        viewModel.fastState.bind { fastState in
            self.timerView.fastState = fastState
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
    }
}

extension TimerViewController: SetTimeDelegate {
    func didReceiveStartedTime(time: Date) {
//        viewModel.timerSetting.value.fastStartTime = time
        // TODO: - to be saved in Realm
    }
}

extension TimerViewController: SetPlanDelegate {
    func didSavedPlanSetting() {
        viewModel.getStoredSetting()
    }
}

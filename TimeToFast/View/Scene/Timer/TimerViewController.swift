//
//  TimerViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit
import SnapKit

protocol SetStartedTimeDelegate: AnyObject {
    func didReceiveStartedTime(time: Date)
}

final class TimerViewController: BaseViewController, SetStartedTimeDelegate {
    
    private lazy var timerView = TimerView(timerSetting: viewModel.timerSetting.value)
    
    private let viewModel = TimerViewModel()
    
    override func loadView() {
        view = timerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerView.backgroundLayer.frame = view.bounds
        view.layer.insertSublayer(timerView.backgroundLayer, at: 0)
        
    }
    
    override func configViewHierarchy() {
        timerView.timerControlButton.addTarget(self, action: #selector(timerControlButtonTapped), for: .touchUpInside)
        
        timerView.fastControlButton.addTarget(self, action: #selector(fastControlButtonTapped), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startedTimeViewTapped))
        timerView.startedTimeView.addGestureRecognizer(tapGestureRecognizer)
        
        let recordButton = UIBarButtonItem(image: UIImage(systemName: "chart.bar.xaxis"), style: .plain, target: self, action: #selector(recordButtonTapped))
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.leftBarButtonItem = recordButton
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func timerControlButtonTapped() {
        viewModel.controlTimer()
    }
    
    @objc func recordButtonTapped() {
        
    }
    
    @objc func settingButtonTapped() {
        
    }
    
    @objc func startedTimeViewTapped() {
        let vc = EditStartedTimeViewController()
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
    
    func didReceiveStartedTime(time: Date) {
        viewModel.timerSetting.value.fastStartTime = time
    }
}

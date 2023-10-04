//
//  TimerViewController.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/09/25.
//

import UIKit
import SnapKit

final class TimerViewController: BaseViewController {
    
    private let timerView = TimerView()
    private let viewModel = TimerViewModel()
    
    override func loadView() {
        view = timerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewComponents()
        
        timerView.fastControlButton.addTarget(self, action: #selector(fastControlButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerView.backgroundLayer.frame = view.bounds
        view.layer.insertSublayer(timerView.backgroundLayer, at: 0)
        
    }
    
    @objc func fastControlButtonTapped() {
        print(#function)
        viewModel.controlTimer()
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

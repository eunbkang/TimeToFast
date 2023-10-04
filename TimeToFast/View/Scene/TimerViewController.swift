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
        
        viewModel.stateTitle.bind { state in
            self.timerView.stateTitleLabel.text = state
        }
        
        viewModel.timeCounter.bind { time in
            self.timerView.timeCounterLabel.text = time
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerView.backgroundLayer.frame = view.bounds
        view.layer.insertSublayer(timerView.backgroundLayer, at: 0)
        
        timerView.fastState = .idle
    }
}

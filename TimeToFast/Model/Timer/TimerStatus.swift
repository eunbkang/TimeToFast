//
//  TimerStatus.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/21.
//

import Foundation

enum TimerStatus {
    case playing
    case stopped
    
    var title: String {
        switch self {
        case .playing:
            return Constants.TimerControl.playing
        case .stopped:
            return Constants.TimerControl.stopped
        }
    }
    
    var image: String {
        switch self {
        case .playing:
            return Constants.TimerControl.playingImage
        case .stopped:
            return Constants.TimerControl.stoppedImage
        }
    }
}

//
//  TimerWidgetView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/28.
//

import SwiftUI
import WidgetKit

struct TimerWidgetView: View {
    var viewModel: TimerWidgetModel
    
    let data: TimerWidgetData
    
    var body: some View {
        ZStack {
            Color(.white)
            LinearGradient(colors: [Color(data.state.widgetBackgroundColor.start), Color(data.state.widgetBackgroundColor.end)], startPoint: .top, endPoint: UnitPoint(x: 1, y: 1.25))
                .opacity(0.75)
            
            ZStack {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: data.fastingTrim)
                        .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .butt))
                        .foregroundColor(Color("lightPurple"))
                        .rotationEffect(Angle(degrees: data.fastingRotation))
                    
                    Circle()
                        .trim(from: 0.0, to: data.eatingTrim)
                        .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .butt))
                        .foregroundColor(Color("lightGreen"))
                        .rotationEffect(Angle(degrees: data.eatingRotation))
                    
                    Circle()
                        .trim(from: 0.0, to: data.fastingTrim)
                        .stroke(style: StrokeStyle(lineWidth: 13, lineCap: .round))
                        .foregroundColor(Color("mainPurple"))
                        .rotationEffect(Angle(degrees: data.fastingRotation))
                }
                
                VStack {
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(.blue)
                        .font(.caption2)
                    
                    Spacer()
                    
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.orange)
                        .font(.caption2)
                }
                .padding(9)
                
                VStack(alignment: .center, spacing: 4) {
                    Text(viewModel.fastState.widgetTitle)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    VStack(alignment: .center) {
                        switch viewModel.fastState {
                        case .idle:
                            Text(viewModel.timeCounter)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                            
                        case .fasting, .fastingBreak, .fastingEarly:
                            Text(viewModel.timerSetting.fastEndTime, style: .timer)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                            
                        case .eating:
                            Text(viewModel.timerSetting.eatingEndTime, style: .timer)
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text(Localizing.State.widgetRemaining)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(16)
        }
    }
}

struct TimerWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerWidgetView(viewModel: TimerWidgetModel(), data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            TimerWidgetView(viewModel: TimerWidgetModel(), data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .dark)
            
            TimerWidgetView(viewModel: TimerWidgetModel(), data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}

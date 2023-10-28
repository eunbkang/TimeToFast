//
//  TimerWidgetView.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/28.
//

import SwiftUI
import WidgetKit

struct TimerWidgetData {
    var stateTitle: String
    var timeCounter: String
//    var startAngle: Double
//    var endAngle: Double
}

extension TimerWidgetData {
    static let previewData = TimerWidgetData(stateTitle: "Time to fast!", timeCounter: "00:00")
}

struct TimerWidgetView: View {
    let data: TimerWidgetData
    
    var body: some View {
        ZStack {
            Color(.white)
            LinearGradient(colors: [Color("lightPurple"), Color("lightGreen")], startPoint: .topLeading, endPoint: UnitPoint(x: 1, y: 1.5))
            
            ZStack {
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: 0.7)
                        .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .butt))
                        .foregroundColor(Color("lightPurple"))
                        .rotationEffect(Angle(degrees: -155.0))
                    
                    Circle()
                        .trim(from: 0.0, to: 0.32)
                        .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .butt))
                        .foregroundColor(Color("lightGreen"))
                        .rotationEffect(Angle(degrees: 90))
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
                
                VStack(spacing: 4) {
                    Text(data.stateTitle)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    VStack {
                        Text(data.timeCounter)
                            .font(.title3)
                            .fontWeight(.heavy)
                        
                        Text("REMAINING")
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
        TimerWidgetView(data: .previewData)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

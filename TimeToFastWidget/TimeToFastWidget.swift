//
//  TimeToFastWidget.swift
//  TimeToFastWidget
//
//  Created by Eunbee Kang on 2023/10/28.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    typealias Entry = TimerWidgetEntry
    
    func placeholder(in context: Context) -> Entry {
        TimerWidgetEntry(date: Date(), configuration: ConfigurationIntent(), viewModel: TimerWidgetModel(configDate: Date()))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = TimerWidgetEntry(date: Date(), configuration: configuration, viewModel: TimerWidgetModel(configDate: Date()))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [TimerWidgetEntry] = []
        let fiveMinute: TimeInterval = 60*5
        var current = Date()
        var viewModel = TimerWidgetModel(configDate: current)
        
        if viewModel.fastState == .fasting || viewModel.fastState == .fastingBreak {
            while current < viewModel.timerSetting.fastEndTime {
                let entry = TimerWidgetEntry(date: current, configuration: configuration, viewModel: TimerWidgetModel(configDate: current))
                current += fiveMinute
                entries.append(entry)
            }
            let timeline = Timeline(entries: entries, policy: .after(viewModel.timerSetting.fastEndTime))
            completion(timeline)
            
        } else if viewModel.fastState == .eating {
            while current < viewModel.timerSetting.eatingEndTime {
                let entry = TimerWidgetEntry(date: current, configuration: configuration, viewModel: TimerWidgetModel(configDate: current))
                current += fiveMinute
                entries.append(entry)
            }
            let timeline = Timeline(entries: entries, policy: .after(viewModel.timerSetting.eatingEndTime))
            completion(timeline)
            
        } else {
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
        }
    }
}

struct TimerWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let viewModel: TimerWidgetModel
}

struct TimeToFastWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        TimerWidgetView()
            .environmentObject(entry.viewModel)
    }
}

struct TimeToFastWidget: Widget {
    let kind: String = "TimeToFastWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TimeToFastWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Fasting Timer")
        .description("Keep track of your fasting state with timer.")
        .supportedFamilies([.systemSmall])
    }
}

struct TimeToFastWidget_Previews: PreviewProvider {
    static var previews: some View {
        TimeToFastWidgetEntryView(entry: TimerWidgetEntry(date: Date(), configuration: ConfigurationIntent(), viewModel: TimerWidgetModel(configDate: Date())))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

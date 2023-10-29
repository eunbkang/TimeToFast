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
        TimerWidgetEntry(date: Date(), configuration: ConfigurationIntent(), model: .previewData, viewModel: TimerWidgetModel())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = TimerWidgetEntry(date: Date(), configuration: configuration, model: .previewData, viewModel: TimerWidgetModel())
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [TimerWidgetEntry] = []
        let currentDate = Date()
        let viewModel = TimerWidgetModel()
        
        let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        let entry = TimerWidgetEntry(date: entryDate, configuration: configuration, model: .previewData, viewModel: viewModel)
            entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct TimerWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let model: TimerWidgetData
    let viewModel: TimerWidgetModel
}

struct TimeToFastWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        TimerWidgetView(viewModel: entry.viewModel, data: entry.model)
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
        TimeToFastWidgetEntryView(entry: TimerWidgetEntry(date: Date(), configuration: ConfigurationIntent(), model: .previewData, viewModel: TimerWidgetModel()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

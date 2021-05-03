//
//  WorkoutCompanionWidget.swift
//  WorkoutCompanionWidget
//
//  Created by Mario Eguiluz on 03/05/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), weekWorkoutDays: WeekWorkoutDays.data)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, weekWorkoutDays: WeekWorkoutDays.data)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, weekWorkoutDays: WeekWorkoutDays.data)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let weekWorkoutDays: WeekWorkoutDays
}

struct WorkoutCompanionWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WeekWorkoutsWidget(weekWorkoutDays: entry.weekWorkoutDays)
    }
}

@main
struct WorkoutCompanionWidget: Widget {
    let kind: String = "WorkoutCompanionWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WorkoutCompanionWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Workout Companion Widget")
        .description("Widgets for workouts and others.")
        .supportedFamilies([.systemMedium])
    }
}

struct WorkoutCompanionWidget_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCompanionWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), weekWorkoutDays: WeekWorkoutDays.data))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

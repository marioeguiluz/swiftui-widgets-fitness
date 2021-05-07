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
    let workoutManager = WorkoutManager(weekWorkoutModel: WeekWorkoutModel(workouts: []))

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), weekWorkoutModel: WeekWorkoutModel.data)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, weekWorkoutModel: WeekWorkoutModel.data)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        workoutManager.latestWorkoutWeekDays { weekWorkoutModel in
            let entryDate = Date()
            let refreshDate = Calendar.current.date(byAdding: .day, value: 1, to: entryDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, weekWorkoutModel: weekWorkoutModel)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let weekWorkoutModel: WeekWorkoutModel
}

struct WorkoutCompanionWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WeekWorkoutsWidget(weekWorkoutModel: entry.weekWorkoutModel)
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
        WorkoutCompanionWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), weekWorkoutModel: WeekWorkoutModel.data))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

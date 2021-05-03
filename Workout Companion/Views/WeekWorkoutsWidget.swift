//
//  WeekWorkoutsWidget.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 28/04/2021.
//

import SwiftUI
import HealthKit

struct WeekWorkoutsWidget: View {
    let weekWorkoutDays: WeekWorkoutDays

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TitleWorkouts()
            Subtitle(weekWorkoutDays: weekWorkoutDays)
            Divider()
                .background(Color(UIColor.systemGray2))
            WeekWorkoutsView(weekWorkoutDays: weekWorkoutDays)
        }
        .padding()
        .background(Color("Card"))
        .cornerRadius(15)
    }
}

struct TitleWorkouts: View {
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "flame.fill")
            Text("Workouts")
        }
        .font(Font.body.bold())
        .foregroundColor(Color("Main"))
    }
}

struct Subtitle: View {
    let weekWorkoutDays: WeekWorkoutDays

    var body: some View {
        Text("You worked out on \(countWeekWorkoutDays(weekWorkoutDays.workoutDays)) of the last 7 days.")
            .font(Font.body.bold())
            .foregroundColor(Color.white)
    }

    private func countWeekWorkoutDays(_ workouts: [WorkoutDay]) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        var days = [false, false, false, false, false, false, false]
        workouts.forEach { (e) in
            if e.workouts.count > 0 {
                let weekDay = myCalendar.component(.weekday, from: e.workouts[0].startDate) - 1
                days[weekDay] = true
            }
        }
        let trainingDays = days.filter{$0}
        return trainingDays.count
    }
}

struct WeekWorkoutsView: View {
    let weekWorkoutDays: WeekWorkoutDays

    var body: some View {
        HStack {
            ForEach(weekWorkoutDays.workoutDays, id: \.id) {
                WorkoutDayRow(workoutDay: $0)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct WorkoutDayRow: View {
    var workoutDay: WorkoutDay

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15) {
            Text(workoutDay.day)
                .font(Font.subheadline.bold())
                .foregroundColor(Color(UIColor.systemGray))
            Text("\(workoutDay.number)")
                .padding(5)
                .frame(width: 35, height: 35, alignment: .center)
                .background(workoutDay.didWorkout ? Color("Main") : Color(UIColor.systemGray2))
                .foregroundColor(workoutDay.didWorkout ? Color(UIColor.white) : Color(UIColor.systemGray))
                .clipShape(
                    Circle()
                )
                .if(workoutDay.isToday) { view in
                    view.overlay(
                        Circle()
                            .stroke(workoutDay.didWorkout ? Color("MainHighlight") : Color(UIColor.systemGray), lineWidth: 4)
                            .padding(1)
                    )
                }

        }
        .lineLimit(1)
        .fixedSize()
    }
}

struct WeekWorkoutsWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeekWorkoutsWidget(weekWorkoutDays: WeekWorkoutDays.data)
                .previewDevice("iPhone 12 Pro")
                .preferredColorScheme(.dark)
        }
    }
}

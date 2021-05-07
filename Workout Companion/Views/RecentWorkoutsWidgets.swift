//
//  LastWorkoutsWidget.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 06/05/2021.
//

import SwiftUI
import HealthKit

struct RecentWorkoutsWidgets: View {
    let workouts: [HKWorkout]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TitleWorkouts()
            Text("Your most recent workouts")
                .font(Font.body.bold())
                .foregroundColor(Color.white)
            Divider()
                .background(Color(UIColor.systemGray2))
            ThreeRowWorkouts(workouts: Array(workouts.prefix(3)))
        }
        .cardStyle()
    }
}

struct ThreeRowWorkouts: View {
    let workouts: [HKWorkout]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(Array(workouts.enumerated()), id: \.offset) { (offset, element) in
                WorkoutRowView(workout: WorkoutRowModel(workout: element))
            }
        }

    }
}

struct WorkoutRowView: View {
    let workout: WorkoutRowModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(workout.imageName)
                .resizable()
                .foregroundColor(Color(UIColor.systemGray))
                .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading, spacing: -5)  {
                Text(workout.activityName)
                    .font(.caption).bold().foregroundColor(Color(UIColor.systemGray))
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(workout.durationHours)")
                            .workoutTitleStyle()
                        + Text(" hr ")
                            .workoutSubheadlineStyle()
                            + Text("\(workout.durationMinutes)")
                            .workoutTitleStyle()
                        + Text(" min")
                            .workoutSubheadlineStyle()
                    }
                    Divider()
                        .background(Color(UIColor.systemGray2))
                    VStack(alignment: .leading, spacing: 5) {
                        Text(workout.energyBurned)
                            .workoutTitleStyle()
                            + Text(" kcal")
                                .workoutSubheadlineStyle()
                    }
                    Divider()
                        .background(Color(UIColor.systemGray2))
                    VStack(alignment: .leading, spacing: 5) {
                        Text(workout.distance)
                            .workoutTitleStyle()
                        + Text(" km")
                            .workoutSubheadlineStyle()
                    }
                }
                .frame(maxHeight: 40)
            }
        }
        .foregroundColor(Color.white)
    }
}

struct RecentWorkoutsWidgets_Previews: PreviewProvider {
    static var previews: some View {
        RecentWorkoutsWidgets(workouts: HKWorkout.data)
            .previewDevice("iPhone 12 Pro")
            .preferredColorScheme(.dark)
    }
}

//
//  WorkoutWidgets.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 01/05/2021.
//

import SwiftUI
import HealthKit

struct WorkoutWidgets: View {
    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        ScrollView {
            VStack {
                WeekWorkoutsWidget(weekWorkoutModel: workoutManager.weekWorkoutModel)
                MapWorkoutWidget(mapWorkoutModel: workoutManager.mapWorkoutModel)
                RecentWorkoutsWidgets(workouts: workoutManager.recentWorkouts)
            }
            .padding()
        }
        .navigationTitle("Workout Widgets")
        .onAppear() {
            workoutManager.loadWorkoutData()
        }
    }
}


struct WorkoutWidgets_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutWidgets().previewDevice("iPhone 12 Pro").environmentObject(
            WorkoutManager(
                weekWorkoutModel: WeekWorkoutModel.data,
                mapWorkoutModel: nil,
                recentWorkouts: HKWorkout.data
            )
        )
    }
}

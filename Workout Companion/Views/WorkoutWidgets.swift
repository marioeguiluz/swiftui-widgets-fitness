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
                WeekWorkoutsWidget(weekWorkoutDays: workoutManager.weekWorkoutDays)
                MapWorkoutWidget(mapWorkout: workoutManager.mapWorkout)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .navigationTitle("Workout")
        .onAppear() {
            workoutManager.latestWorkoutWeekDays()
            workoutManager.latestMapWorkout()
        }

    }
}


struct WorkoutWidgets_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutWidgets().previewDevice("iPhone 12 Pro").environmentObject(WorkoutManager(weekWorkoutDays: WeekWorkoutDays.data ))
    }
}



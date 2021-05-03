//
//  Workout_CompanionApp.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 26/04/2021.
//

import SwiftUI

@main
struct Workout_CompanionApp: App {
  private let workoutManager = WorkoutManager(weekWorkoutDays: WeekWorkoutDays(workouts: []))

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .frame(maxWidth: .infinity)
                    .environmentObject(workoutManager)

            }
            .onAppear() {
                workoutManager.requestAuthorization()
            }
        }
    }
}

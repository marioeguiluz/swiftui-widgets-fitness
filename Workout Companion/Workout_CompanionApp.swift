//
//  Workout_CompanionApp.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 26/04/2021.
//

import SwiftUI

@main
struct Workout_CompanionApp: App {
    
    @State private var showingAlert = false
    @State private var errorMesage = ""

    @StateObject var workoutManager = WorkoutManager(weekWorkoutDays: WeekWorkoutDays(workouts: []))
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .frame(maxWidth: .infinity)
                    .environmentObject(workoutManager)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Something went wrong..."), message: Text(errorMesage), dismissButton: .default(Text("Ok")))
            }
            .onAppear() {
                workoutManager.requestAuthorization {
                    workoutManager.loadWorkoutData()
                } onError: { error in
                    if let error = error {
                        errorMesage = error.localizedDescription
                    }
                    showingAlert = true
                }
            }
        }
    }
}

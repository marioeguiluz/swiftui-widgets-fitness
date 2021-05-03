//
//  WorkoutDay.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 01/05/2021.
//

import Foundation
import HealthKit

struct WorkoutDay: Identifiable {
    let id: UUID
    let date: Date
    let workouts: [HKWorkout]

    var day: String {
        return date.weekday()
    }

    var  number: Int {
        return date.day()
    }

    var didWorkout: Bool {
        return workouts.count > 0
    }

    var isToday: Bool {
        return Calendar.current.isDateInToday(date)
    }

    init(date: Date, workouts: [HKWorkout]) {
        self.id = UUID()
        self.date = date
        self.workouts = workouts
    }
}

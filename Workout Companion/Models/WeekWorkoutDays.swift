//
//  WeekWorkouts.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 01/05/2021.
//

import HealthKit

struct WeekWorkoutDays {
    let workoutDays: [WorkoutDay]

    init(workouts: [HKWorkout]) {
        let today = Date()
        var workoutDays: [WorkoutDay] = []
        [0,1,2,3,4,5,6].forEach { e in
            let date = Calendar.current.date(byAdding: .day, value: -e, to: today)!
            let dateWorkouts = workouts.filter { Calendar.current.isDate($0.startDate, equalTo: date, toGranularity: .day) }
            workoutDays.append(WorkoutDay(date: date, workouts: dateWorkouts))
        }
        self.workoutDays = workoutDays.reversed()
    }
}

extension WeekWorkoutDays {
    static var data = WeekWorkoutDays(workouts: [
        generateWorkout(daysAgo: 6),
        generateWorkout(daysAgo: 6),
        generateWorkout(daysAgo: 4),
        generateWorkout(daysAgo: 3),
        generateWorkout(daysAgo: 1),
        generateWorkout(daysAgo: 1)
    ])

    private static func generateWorkout(daysAgo: Int) -> HKWorkout {
        let totalEnergyBurned = Double.random(in: 350..<651)
        let today = Date()
        let start = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        let end = Calendar.current.date(byAdding: .minute, value: 60, to: start)!
        let workout = HKWorkout(
            activityType: .traditionalStrengthTraining,
            start: start,
            end: end,
            duration: 60,
            totalEnergyBurned: HKQuantity(unit: .kilocalorie(), doubleValue: totalEnergyBurned),
            totalDistance: nil, device: nil, metadata: nil)
        return workout
    }
}

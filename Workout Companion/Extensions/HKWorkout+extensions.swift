//
//  HKWorkout+extensions.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 07/05/2021.
//

import HealthKit

extension HKWorkout {
    static var data = [
        generateWorkoutWithActivity(daysAgo: 0, activityType: .walking),
        generateWorkoutWithActivity(daysAgo: 0, activityType: .traditionalStrengthTraining),
        generateWorkoutWithActivity(daysAgo: 1, activityType: .tennis),
        generateWorkoutWithActivity(daysAgo: 3, activityType: .running)
    ]

    private static func generateWorkoutWithActivity(daysAgo: Int, activityType: HKWorkoutActivityType) -> HKWorkout {
        let totalEnergyBurned = Double.random(in: 350..<651)
        let totalDistance = Double.random(in: 1500..<6555)
        let duration = Double.random(in: 3500..<7500)
        let today = Date()
        let start = Calendar.current.date(byAdding: .day, value: -daysAgo, to: today)!
        let end = Calendar.current.date(byAdding: .minute, value: 60, to: start)!
        let workout = HKWorkout(
            activityType: activityType,
            start: start,
            end: end,
            duration: duration,
            totalEnergyBurned: HKQuantity(unit: .kilocalorie(), doubleValue: totalEnergyBurned),
            totalDistance: HKQuantity(unit: .meter(), doubleValue: totalDistance),
            device: nil, metadata: nil)
        return workout
    }
}

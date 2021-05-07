//
//  MapWorkout.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 01/05/2021.
//

import HealthKit
import MapKit

struct MapWorkoutModel {
    let workout: HKWorkout
    let region: MKCoordinateRegion?
    let coordinates: [CLLocationCoordinate2D]?

    var summary: String {
        return "Your last walk was \(String(format:"%0.2f km", distance)) long with an average pace of \(pace) per km"
    }
    var distance: Double {
        return workout.totalDistance != nil ? workout.totalDistance!.doubleValue(for: HKUnit.meter())/1000 : 0
    }

    var durationHours: Int {
        return Int(floor(workout.duration / 3600))
    }

    var durationMinutes: Int {
        return  Int(floor(workout.duration.truncatingRemainder(dividingBy: 3600)) / 60)
    }

    var pace: String {
        let durationDecimal = workout.duration / 60
        let paceDecimal = durationDecimal / distance
        let paceMins = Int(floor(paceDecimal))
        let paceSecs = Int(floor(paceDecimal * 60).truncatingRemainder(dividingBy: 60))
        return String(format:"%d minutes, %02d seconds", paceMins, paceSecs)
    }

    var type: HKWorkoutActivityType {
        return workout.workoutActivityType
    }

    var kcal: Double {
        return workout.totalEnergyBurned != nil ? workout.totalEnergyBurned!.doubleValue(for: HKUnit.kilocalorie()) : 0
    }
}

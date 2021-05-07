//
//  WorkoutManager.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 27/04/2021.
//

import Foundation
import HealthKit
import Combine
import MapKit


class WorkoutManager: NSObject, ObservableObject {

    @Published var weekWorkoutModel = WeekWorkoutModel(workouts: [])
    @Published var mapWorkoutModel: MapWorkoutModel? = nil
    @Published var recentWorkouts: [HKWorkout] = []

    private var healthStore: HKHealthStore?

    init(
        weekWorkoutModel: WeekWorkoutModel = WeekWorkoutModel(workouts: []),
        mapWorkoutModel: MapWorkoutModel? = nil,
        recentWorkouts: [HKWorkout] = []) {
        
        self.weekWorkoutModel = weekWorkoutModel
        self.mapWorkoutModel = mapWorkoutModel
        self.recentWorkouts = recentWorkouts

        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }

    func requestAuthorization(onSuccess: @escaping () -> Void, onError: @escaping (Error?) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            let typesToRead: Set = [
                HKObjectType.workoutType(),
                HKSeriesType.workoutRoute(),
                HKQuantityType.quantityType(forIdentifier: .heartRate)!,
                HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            ]
            healthStore?.requestAuthorization(toShare: nil, read: typesToRead) { (result, error) in
                if let error = error {
                    onError(error)
                    return
                }
                guard result else {
                    onError(nil)
                    return
                }
                onSuccess()
           }
        }
    }
    
    func loadWorkoutData() {
        latestMapWorkout()
        latestWorkoutWeekDays()
        latestWorkouts()
    }

    // LAST WEEK WORKOUTS

    func latestWorkoutWeekDays(completion: ((WeekWorkoutModel) -> Void)? = nil) {
        let end = Date()
        let start = Calendar.current.date(byAdding: .day, value: -7, to: end)!
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .greaterThanOrEqualTo, duration: 1)
        let datePredicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates:[workoutPredicate, datePredicate])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: compound,
            limit: 0,
            sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples as? [HKWorkout], error == nil else {
                    let result = WeekWorkoutModel(workouts: [])
                    self.weekWorkoutModel = result
                    completion?(result)
                    return
                }
                let result =  WeekWorkoutModel(workouts: samples)
                self.weekWorkoutModel = result
                completion?(result)
            }
          }

        healthStore?.execute(query)
    }

    // MAP WORKOUT

    func latestMapWorkout() {
        let walkingPredicate = HKQuery.predicateForWorkouts(with: .walking)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: walkingPredicate, limit: 5, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples as? [HKWorkout], error == nil, let mapWorkout = samples.first else {
                    self.mapWorkoutModel = nil
                    return
                }
                self.publishMapWorkout(workout: mapWorkout)
            }
        }
        healthStore?.execute(query)
    }

    private func publishMapWorkout(workout: HKWorkout) {
        let workoutRouteType = HKSeriesType.workoutRoute()
        let workoutPredicate = HKQuery.predicateForObjects(from: workout)
        let workoutRoutesQuery = HKSampleQuery(sampleType: workoutRouteType, predicate: workoutPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in

            guard let routeSamples = samples as? [HKWorkoutRoute] else { return }
            var accumulator: [CLLocation] = []
            for routeSample in routeSamples {
                let locationQuery = HKWorkoutRouteQuery(route: routeSample) { (routeQuery, locations, done, error) in
                    if let locations = locations {
                        accumulator.append(contentsOf: locations)
                        if done {
                            let coordinates2D = accumulator.map { $0.coordinate }
                            let region = MKCoordinateRegion(coordinates: coordinates2D)
                            DispatchQueue.main.async {
                                self.mapWorkoutModel = MapWorkoutModel(workout: workout, region: region, coordinates: coordinates2D)
                            }
                        }
                    }
                }
                self.healthStore?.execute(locationQuery)
            }
        }
        healthStore?.execute(workoutRoutesQuery)
    }
    
    // RECENT WORKOUTS
    
    func latestWorkouts(completion: (([HKWorkout]) -> Void)? = nil) {
        let end = Date()
        let start = Calendar.current.date(byAdding: .day, value: -7, to: end)!
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .greaterThanOrEqualTo, duration: 1)
        let datePredicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates:[workoutPredicate, datePredicate])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: compound,
            limit: 0,
            sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples as? [HKWorkout], error == nil else {
                    self.recentWorkouts = []
                    completion?([])
                    return
                }
                self.recentWorkouts = samples
                completion?(samples)
            }
          }

        healthStore?.execute(query)
    }
}

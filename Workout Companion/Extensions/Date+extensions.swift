//
//  Date+extensions.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 28/04/2021.
//

import Foundation

extension Date {
    
    func weekday() -> String {
        let weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        return String(weekDays[weekDay-1].prefix(3))
    }

    func day() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        return myCalendar.component(.day, from: self)
    }
}

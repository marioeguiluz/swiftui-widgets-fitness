//
//  Array+extensions.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 08/05/2021.
//

import Foundation

extension Array {
    func batched(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

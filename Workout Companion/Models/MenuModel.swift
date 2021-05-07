//
//  Menu.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 01/05/2021.
//

import SwiftUI

enum MenuModel: CaseIterable, Identifiable {
    case workout
    case activeEnergy
    case heartRate
    case steps
    case sleep

    var id: String { return UUID().uuidString }

    func title() -> String {
        switch self {
        case .workout:
            return "Workout"
        case .activeEnergy:
            return "Active Energy"
        case .heartRate:
            return "Heart Rate"
        case .steps:
            return "Steps"
        case .sleep:
            return "Sleep"
        }
    }

    func imageSystemNames() -> String {
        switch self {
        case .workout:
            return "flame.fill"
        case .activeEnergy:
            return "bolt.fill"
        case .heartRate:
            return "heart.fill"
        case .steps:
            return "figure.walk.circle.fill"
        case .sleep:
            return "powersleep"
        }
    }

    func color() -> Color {
        switch self {
        case .workout:
            return .red
        case .activeEnergy:
            return .yellow
        case .heartRate:
            return .pink
        case .steps:
            return .orange
        case .sleep:
            return .purple
        }
    }
}

extension MenuModel {
    static var data = {
        return [
            MenuModel.workout,
            MenuModel.activeEnergy,
            MenuModel.heartRate,
            MenuModel.steps,
            MenuModel.sleep
        ]
    }
}

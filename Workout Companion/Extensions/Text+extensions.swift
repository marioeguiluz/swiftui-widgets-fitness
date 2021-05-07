//
//  Text+extensions.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 07/05/2021.
//

import SwiftUI

extension Text {
    func workoutSubheadlineStyle() -> Text {
        self
            .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
    }
    
    func workoutTitleStyle() -> Text {
        self
            .font(.title3).bold().foregroundColor(.white)
    }
}

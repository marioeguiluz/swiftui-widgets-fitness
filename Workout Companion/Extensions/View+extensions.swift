//
//  View+extensions.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 28/04/2021.
//

import SwiftUI

// From: https://www.avanderlee.com/swiftui/conditional-view-modifier/

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color("Card"))
            .cornerRadius(15)
    }
}

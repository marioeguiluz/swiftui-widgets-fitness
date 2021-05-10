//
//  ContentView.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 26/04/2021.
//

import SwiftUI
import HealthKit

struct MenuView: View {
    var body: some View {
        List {
            ForEach(MenuModel.allCases) { item in
                NavigationLink(destination: destination(for: item)) {
                    Label(item.title(), systemImage: item.imageSystemNames())
                        .foregroundColor(item.color())
                        .padding()
                }
                .listRowBackground(Color("Card"))
            }
        }
        .navigationTitle("Widgets")
    }

    @ViewBuilder
    private func destination(for menuItem: MenuModel) -> some View {
        switch menuItem {
        case .workout:
            WorkoutWidgets()
        default:
            WIP()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().previewDevice("iPhone 12 Pro")
    }
}

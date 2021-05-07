//
//  WeekWorkoutsWidget.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 28/04/2021.
//

import SwiftUI
import HealthKit

struct WeekWorkoutsWidget: View {
    let weekWorkoutModel: WeekWorkoutModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TitleWorkouts()
            Text(weekWorkoutModel.summary)
                .font(Font.body.bold())
                .foregroundColor(Color.white)
            Divider()
                .background(Color(UIColor.systemGray2))
            WeekWorkoutsView(weekWorkoutModel: weekWorkoutModel)
        }
        .cardStyle()
    }
}

struct TitleWorkouts: View {
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "flame.fill")
            Text("Workouts")
        }
        .font(Font.body.bold())
        .foregroundColor(Color("Main"))
    }
}

struct WeekWorkoutsView: View {
    let weekWorkoutModel: WeekWorkoutModel

    var body: some View {
        HStack {
            ForEach(weekWorkoutModel.workoutDays, id: \.id) {
                WorkoutDayRowView(workoutDayModel: $0)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct WorkoutDayRowView: View {
    var workoutDayModel: WorkoutDayModel

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15) {
            Text(workoutDayModel.day)
                .font(Font.subheadline.bold())
                .foregroundColor(Color(UIColor.systemGray))
            Text("\(workoutDayModel.number)")
                .padding(5)
                .frame(width: 35, height: 35, alignment: .center)
                .background(workoutDayModel.didWorkout ? Color("Main") : Color(UIColor.systemGray2))
                .foregroundColor(workoutDayModel.didWorkout ? Color(UIColor.white) : Color(UIColor.systemGray))
                .clipShape(
                    Circle()
                )
                .if(workoutDayModel.isToday) { view in
                    view.overlay(
                        Circle()
                            .stroke(workoutDayModel.didWorkout ? Color("MainHighlight") : Color(UIColor.systemGray), lineWidth: 4)
                            .padding(1)
                    )
                }

        }
        .lineLimit(1)
        .fixedSize()
    }
}

struct WeekWorkoutsWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeekWorkoutsWidget(weekWorkoutModel: WeekWorkoutModel.data)
                .previewDevice("iPhone 12 Pro")
                .preferredColorScheme(.dark)
        }
    }
}

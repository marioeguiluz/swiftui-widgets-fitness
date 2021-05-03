//
//  MapWorkoutWidget.swift
//  Workout Companion
//
//  Created by Mario Eguiluz on 29/04/2021.
//

import SwiftUI
import HealthKit
import MapKit

struct MapWorkoutWidget: View {
    var mapWorkout: MapWorkout?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TitleWorkouts()
            if let mapWorkout = mapWorkout {
                SubtitleMapWorkout(workout: mapWorkout)
                Divider()
                    .background(Color(UIColor.systemGray2))
                if let region = mapWorkout.region, let coordinates = mapWorkout.coordinates {
                    MapView(coordinates: coordinates, region: region)
                        .frame(maxWidth: .infinity, idealHeight: 200)
                    MapViewFooter(mapWorkout: mapWorkout)
                }
            } else {
                Text("Waiting for a walking workout...")
            }
        }
        .padding()
        .background(Color("Card"))
        .cornerRadius(15)
    }
}

struct SubtitleMapWorkout: View {
    let workout: MapWorkout

    var body: some View {
        Text("Your last walk was \(String(format:"%0.2f km", workout.distance)) long with an average pace of \(workout.pace) per km")
            .font(Font.body.bold())
            .foregroundColor(Color.white)
    }
}

struct MapView: UIViewRepresentable {
    let coordinates: [CLLocationCoordinate2D]
    let region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if coordinates.count > 0 {
            view.setRegion(region, animated: true)
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            view.addOverlay(polyline)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let polylineRenderer = MKPolylineRenderer(overlay: overlay)
                polylineRenderer.strokeColor = UIColor.red
                polylineRenderer.lineWidth = 5
                return polylineRenderer
            }

            return MKOverlayRenderer()
        }
    }
}

struct MapViewFooter: View {
    let mapWorkout: MapWorkout

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Distance")
                    .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
                Text(String(format:"%0.2f", mapWorkout.distance))
                    .font(.title).bold().foregroundColor(.white)
                + Text(" km")
                    .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
            }
            Divider()
                .background(Color(UIColor.systemGray2))
            VStack(alignment: .leading, spacing: 5) {
                Text("Duration")
                    .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
                Text("\(mapWorkout.durationHours)")
                    .font(.title).bold().foregroundColor(.white)
                + Text(" hr ")
                    .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
                + Text("\(mapWorkout.durationMinutes)")
                    .font(.title).bold().foregroundColor(.white)
                + Text(" min")
                    .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
            }
            Divider()
                .background(Color(UIColor.systemGray2))
            VStack(alignment: .leading, spacing: 5) {
                Text("Energy")
                    .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
                Text(String(format:"%.0f", mapWorkout.kcal))
                    .font(.title).bold().foregroundColor(.white)
                    + Text(" kcal")
                        .font(.subheadline).bold().foregroundColor(Color(UIColor.systemGray))
            }
        }
        .frame(maxHeight: 50)
    }
}

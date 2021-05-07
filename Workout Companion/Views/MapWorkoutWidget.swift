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
    var mapWorkoutModel: MapWorkoutModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TitleWorkouts()
            if let mapWorkoutModel = mapWorkoutModel {
                Text(mapWorkoutModel.summary)
                    .font(Font.body.bold())
                    .foregroundColor(Color.white)
                Divider()
                    .background(Color(UIColor.systemGray2))
                if let region = mapWorkoutModel.region, let coordinates = mapWorkoutModel.coordinates {
                    MapView(coordinates: coordinates, region: region)
                        .frame(maxWidth: .infinity, idealHeight: 200)
                }
                MapViewFooter(mapWorkoutModel: mapWorkoutModel)
            } else {
                Text("Waiting for a walking workout...")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .cardStyle()
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
    let mapWorkoutModel: MapWorkoutModel

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Distance")
                    .workoutSubheadlineStyle()
                Text(String(format:"%0.2f", mapWorkoutModel.distance))
                    .workoutTitleStyle()
                + Text(" km")
                    .workoutSubheadlineStyle()
            }
            Divider()
                .background(Color(UIColor.systemGray2))
            VStack(alignment: .leading, spacing: 5) {
                Text("Duration")
                    .workoutSubheadlineStyle()
                Text("\(mapWorkoutModel.durationHours)")
                    .workoutTitleStyle()
                + Text(" hr ")
                    .workoutSubheadlineStyle()
                + Text("\(mapWorkoutModel.durationMinutes)")
                    .workoutTitleStyle()
                + Text(" min")
                    .workoutSubheadlineStyle()
            }
            Divider()
                .background(Color(UIColor.systemGray2))
            VStack(alignment: .leading, spacing: 5) {
                Text("Energy")
                    .workoutSubheadlineStyle()
                Text(String(format:"%.0f", mapWorkoutModel.kcal))
                    .workoutTitleStyle()
                    + Text(" kcal")
                        .workoutSubheadlineStyle()
            }
        }
        .frame(maxHeight: 50)
    }
}

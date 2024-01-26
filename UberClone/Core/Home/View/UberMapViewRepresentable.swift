//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinates = locationSearchViewModel.selectedLocationCoordinates {
            context.coordinator.addAndSelectAnnotation(withCoordinates: coordinates)
        }
    }

    func makeCoordinator() -> UberMapViewCoordinator {
        UberMapViewCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class UberMapViewCoordinator: NSObject, MKMapViewDelegate {
        // MARK: - Properties
        let parent: UberMapViewRepresentable

        // MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        // MARK: - MKMapView Delegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
            parent.mapView.setRegion(region, animated: true)
        }

        // MARK: - Helpers
        func addAndSelectAnnotation(withCoordinates coordinates: CLLocationCoordinate2D) {
            /// Delete all the previous selected locations.
            parent.mapView.removeAnnotations(parent.mapView.annotations)

            /// Make the annotation out of the coordinates.
            let anno = MKPointAnnotation ()
            anno.coordinate = coordinates
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            /// For zooming into the selected location .
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
    }
}

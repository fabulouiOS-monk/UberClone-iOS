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
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinates = locationSearchViewModel.selectedLocationCoordinates {
                context.coordinator.addAndSelectAnnotation(withCoordinates: coordinates)
                context.coordinator.configPolyline(withDestinationCoordinates: coordinates)
            }
        }

//        if mapState == .noInput {
//            context.coordinator.clearMapViewAndRecenterUserLocation()
//        }
    }

    func makeCoordinator() -> UberMapViewCoordinator {
        UberMapViewCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class UberMapViewCoordinator: NSObject, MKMapViewDelegate {
        // MARK: - Properties
        let parent: UberMapViewRepresentable
        var userLocationCoordinates: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?

        // MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        // MARK: - MKMapView Delegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            userLocationCoordinates = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
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
            
//            /// For zooming into the selected location. UPDATE: we commented the code since now we will be
            /// zooming-in within the configPolyline().
//            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }

        func configPolyline(withDestinationCoordinates coordinates: CLLocationCoordinate2D) {
            guard let userLocationCoordinates else { return }
            getDestinationRoute(from: userLocationCoordinates,
                                to: coordinates) { route in
                self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,
                                                               edgePadding: .init(top: 64,
                                                                                  left: 32,
                                                                                  bottom: 500,
                                                                                  right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                                 to destination: CLLocationCoordinate2D,
                                 completion: @escaping (MKRoute) -> ()) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error {
                    print("[Error]: \(error.localizedDescription)")
                    return
                }

                guard let routes = response?.routes.first else { return }
                completion(routes)
            }
        }

        func clearMapViewAndRecenterUserLocation () {
            parent.mapView.removeOverlays(parent.mapView.overlays)
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}

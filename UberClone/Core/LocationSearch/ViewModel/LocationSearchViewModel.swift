//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Kailash Bora on 22/01/24.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {

    // MARK: - Properties
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickUpTime: String?
    @Published var dropOffTime: String?
    var userLocation: CLLocationCoordinate2D?

    private var searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }

    // MARK: - Helpers
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { result, error in
            guard let item = result?.mapItems.first else { return }
            let coordinates = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title,
                                                               location: coordinates)
            print("[DEBUG COORDINATES]: \(coordinates)")
        }
    }

    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)

        search.start(completionHandler: completion )
        
    }

    func computePrice(forType type: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.location else { return 0.0 }
        guard let userLocation = self.userLocation else { return 0.0 }
        let userLoc = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destLoc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeters = userLoc.distance(from: destLoc)
        return type.computePrice(for: tripDistanceInMeters)
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
            self.configurePickupAndDropOffTime(with: routes.expectedTravelTime)
            completion(routes)
        }
    }

    func configurePickupAndDropOffTime(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        self.pickUpTime = formatter.string(from: Date())
        self.dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}

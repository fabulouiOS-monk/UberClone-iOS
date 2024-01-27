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
    @Published var selectedLocationCoordinates: CLLocationCoordinate2D?
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
            self.selectedLocationCoordinates = coordinates
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
        guard let coordinate = selectedLocationCoordinates else { return 0.0 }
        guard let userLocation = self.userLocation else { return 0.0 }
        let userLoc = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destLoc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeters = userLoc.distance(from: destLoc)
        return type.computePrice(for: tripDistanceInMeters)
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

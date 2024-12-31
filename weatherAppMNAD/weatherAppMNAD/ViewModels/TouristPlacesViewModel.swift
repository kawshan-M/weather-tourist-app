//
//  TouristPlacesViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation
import SwiftUI
import MapKit

class TouristPlacesViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var touristPlaces: [TouristPlace] = []

    func fetchTouristPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Tourist Attraction"
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error fetching tourist places: \(error.localizedDescription)")
            } else if let mapItems = response?.mapItems {
                DispatchQueue.main.async {
                    self.touristPlaces = mapItems.prefix(5).map { mapItem in
                        TouristPlace(
                            name: mapItem.name ?? "Unknown",
                            coordinate: mapItem.placemark.coordinate,
                            address: mapItem.placemark.title ?? "No Address"
                        )
                    }
                }
            }
        }
    }

    func updateRegionAndFetchCityName(latitude: Double, longitude: Double) {
        region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        fetchTouristPlaces()
    }
}

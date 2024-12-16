//
//  TouristPlacesViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation
import MapKit

class TouristPlacesViewModel: ObservableObject {
    @Published var touristPlaces: [TouristPlace] = []

    func fetchTouristPlaces() {
        // Dummy data for now; replace with real MapKit query
        let places = [
            TouristPlace(name: "Place 1", coordinate: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612)),
            TouristPlace(name: "Place 2", coordinate: CLLocationCoordinate2D(latitude: 6.9219, longitude: 79.8577))
        ]
        touristPlaces = places
    }
}

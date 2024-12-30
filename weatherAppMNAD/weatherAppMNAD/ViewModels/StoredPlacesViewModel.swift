//
//  StoredPlacesViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation
import FirebaseFirestore
import MapKit
import SwiftData

class StoredPlacesViewModel: ObservableObject {
    @Published var storedPlaces: [String] = []
    @Published var searchResults: [MKMapItem] = []
    @Published var favoriteCities: [Town] = []
    
    private var modelContext: ModelContext
    
    init(context: ModelContext) {
        self.modelContext = context
        fetchFavoriteCities()
    }


    private let db = Firestore.firestore()

    func addPlace(name: String) {
        db.collection("places").addDocument(data: ["name": name]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
        }
    }

    func fetchStoredPlaces() {
        db.collection("places").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching places: \(error)")
            } else if let snapshot = snapshot {
                self.storedPlaces = snapshot.documents.map { $0["name"] as? String ?? "" }
            }
        }
    }
    
    private func fetchFavoriteCities() {
        if let fetchedCities = try? modelContext.fetch(FetchDescriptor<Town>()) {
            self.favoriteCities = fetchedCities
        } else {
            self.favoriteCities = []
        }
    }
    
    func searchForCity(query: String, completion: @escaping (Result<MKMapItem, Error>) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let error = error {
                completion(.failure(error))
            } else if let firstResult = response?.mapItems.first {
                DispatchQueue.main.async {
                    self.searchResults = response?.mapItems ?? []
                    self.addToFavorites(
                        name: firstResult.name ?? "Unknown",
                        latitude: firstResult.placemark.coordinate.latitude,
                        longitude: firstResult.placemark.coordinate.longitude
                    )
                    completion(.success(firstResult))
                }
            } else {
                completion(.failure(NSError(domain: "NoResults", code: 404, userInfo: [NSLocalizedDescriptionKey: "City not found."])))
            }
        }
    }

    func addToFavorites(name: String, latitude: Double, longitude: Double) {
        let city = Town(name: name, latitude: latitude, longitude: longitude)
        if !favoriteCities.contains(where: { $0.name == name }) {
            modelContext.insert(city)
            try? modelContext.save()
            fetchFavoriteCities()
        }
    }
    
    func deleteCity(at offsets: IndexSet) {
        for index in offsets {
            let city = favoriteCities[index]
            
            do {
                modelContext.delete(city)
                try modelContext.save()
                fetchFavoriteCities()
            } catch {
                print("Failed to delete city: \(error)")
            }
        }

        // Update the UI by removing from the array
        favoriteCities.remove(atOffsets: offsets)
    }
}

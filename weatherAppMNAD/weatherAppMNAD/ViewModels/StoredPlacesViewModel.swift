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
import SwiftUI
import FirebaseAuth

class StoredPlacesViewModel: ObservableObject {
    @Published var storedPlaces: [String] = []
    @Published var searchResults: [MKMapItem] = []
    @Published var favoriteCities: [Town] = []
    
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    @AppStorage("currentCity") var currentCity: String = "London"
    
    private var modelContext: ModelContext // The SwiftData context for managing database operations.
    private let db = Firestore.firestore()
    
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init(context: ModelContext) {
        self.modelContext = context
        fetchFavoriteCitiesFromFirestore()
    }
    

    func addPlace(name: String, latitude: Double, longitude: Double) {
        guard let userId = userId else { return }
        
        let cityData: [String: Any] = [
            "name": name,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        db.collection("users").document(userId).collection("favoriteCities")
            .addDocument(data: cityData) { error in
                if let error = error {
                    print("Error adding city to Firestore: \(error)")
                } else {
                    let city = Town(name: name, latitude: latitude, longitude: longitude)
                    if !self.favoriteCities.contains(where: { $0.name == name }) {
                        self.modelContext.insert(city)
                        try? self.modelContext.save()
                        self.fetchFavoriteCities()
                    }
                     // Refresh the list
                }
            }
    }

    func fetchFavoriteCitiesFromFirestore() {
        guard let userId = userId else { return }
        
        db.collection("users").document(userId).collection("favoriteCities")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching favorite cities: \(error)")
                } else if let snapshot = snapshot {
                    self.clearSwiftData()  // Clear existing SwiftData entries
                    
                    for document in snapshot.documents {
                        let data = document.data()
                        let name = data["name"] as? String ?? ""
                        let latitude = data["latitude"] as? Double ?? 0
                        let longitude = data["longitude"] as? Double ?? 0
                        
                        let city = Town(name: name, latitude: latitude, longitude: longitude)
                        self.modelContext.insert(city)
                    }
                    
                    try? self.modelContext.save()
                    
                    self.fetchFavoriteCities()
                }
            }
    }
    
    private func clearSwiftData() {
        if let cities = try? modelContext.fetch(FetchDescriptor<Town>()) {
            for city in cities {
                modelContext.delete(city)
            }
            try? modelContext.save()
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
                    self.addPlace(
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
    
    func deleteCity(at offsets: IndexSet) {
        guard let userId = userId else { return }
        
        offsets.forEach { index in
            let city = favoriteCities[index]
            
            db.collection("users").document(userId).collection("favoriteCities")
                .whereField("name", isEqualTo: city.name)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error finding city to delete: \(error)")
                    } else if let document = snapshot?.documents.first {
                        document.reference.delete { error in
                            if let error = error {
                                print("Error deleting city: \(error)")
                            } else {
                                self.modelContext.delete(city)
                                try? self.modelContext.save()
                                self.fetchFavoriteCities()
                            }
                        }
                    }
                }
        }

        favoriteCities.remove(atOffsets: offsets)
        
        if favoriteCities.isEmpty {
            currentCity = "London"
            latitude = 51.5074
            longitude = -0.1278
        }
    }
}

//
//  StoredPlacesViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation
import FirebaseFirestore

class StoredPlacesViewModel: ObservableObject {
    @Published var storedPlaces: [String] = [] // List of stored locations

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
}

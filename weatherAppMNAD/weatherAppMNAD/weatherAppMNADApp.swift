//
//  weatherAppMNADApp.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import FirebaseCore
import SwiftData
import Firebase

@main
struct weatherAppMNADApp: App {
    @StateObject private var locationVM: StoredPlacesViewModel
    @StateObject private var networkMonitor = NetworkMonitor()
    
    init() {
        FirebaseApp.configure()
        
        let context = PersistenceController.shared.container.mainContext
        _locationVM = StateObject(wrappedValue: StoredPlacesViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationVM)
                .environmentObject(networkMonitor)
                .modelContainer(PersistenceController.shared.container)
        }
    }
}

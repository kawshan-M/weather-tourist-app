//
//  weatherAppMNADApp.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import FirebaseCore
import SwiftData

@main
struct weatherAppMNADApp: App {
    @StateObject var viewModel = ViewModel()
    @StateObject private var locationVM: StoredPlacesViewModel
    
    init() {
        FirebaseApp.configure()
        
        let context = PersistenceController.shared.container.mainContext
        _locationVM = StateObject(wrappedValue: StoredPlacesViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(locationVM)
                .modelContainer(PersistenceController.shared.container)
        }
    }
}

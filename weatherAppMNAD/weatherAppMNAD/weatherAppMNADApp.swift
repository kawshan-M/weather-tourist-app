//
//  weatherAppMNADApp.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import FirebaseCore

@main
struct weatherAppMNADApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

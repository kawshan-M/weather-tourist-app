//
//  DatabaseController.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-30.
//

import Foundation
import SwiftData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Town.self)
        } catch {
            fatalError("Failed to initialize SwiftData container: \(error)")
        }
    }
}

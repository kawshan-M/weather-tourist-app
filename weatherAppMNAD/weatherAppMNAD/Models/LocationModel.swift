//
//  LocationModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-25.
//

import Foundation
import SwiftData
// MARK:   LocationModel class to be used with SwiftData - database to store places information
// add suitable macro

@Model
class Town {
    @Attribute(.unique) var id: UUID
        var name: String
        var latitude: Double
        var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

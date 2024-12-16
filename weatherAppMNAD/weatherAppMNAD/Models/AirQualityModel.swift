//
//  AirQualityModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation

struct AirQualityResponse: Codable {
    let list: [AirQualityItem]
}

struct AirQualityItem: Codable {
    let main: AirQualityMain
}

struct AirQualityMain: Codable {
    let aqindex: Int
}

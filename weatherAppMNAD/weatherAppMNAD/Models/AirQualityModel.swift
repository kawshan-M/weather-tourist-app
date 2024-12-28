//
//  AirQualityModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation

struct AirQualityData: Codable {
    let list: [AirQualityDetails]
}

struct AirQualityDetails: Codable {
    let main: AirQualityMain
    let components: AirQualityComponents
}

struct AirQualityMain: Codable {
    let aqi: Int
}

struct AirQualityComponents: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}

//
//  AirQualityModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation

/* Code for AirDataModel Struct */

struct AirDataModel: Codable{

    // MARK:  list of attributes to map response from openweather pollution api
}

struct AirQualityResponse: Codable {
    let list: [AirQualityItem]
}

struct AirQualityItem: Codable {
    let main: AirQualityMain
}

struct AirQualityMain: Codable {
    let aqindex: Int
}

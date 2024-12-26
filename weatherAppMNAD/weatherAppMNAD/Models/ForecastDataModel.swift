//
//  ForecastDataModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-26.
//

import Foundation

struct HourlyWeatherUI: Identifiable {
    let id = UUID()
    let time: String
    let temperature: String
    let icon: String

    init(hour: HourlyWeather) {
        self.time = DateFormatterUtils.formattedDate(from: hour.dt, format: "ha")
        self.temperature = "\(Int(hour.temp))°C"
        self.icon = hour.weather.first?.icon ?? ""
    }
}

struct DailyWeatherUI: Identifiable {
    let id = UUID()
    let day: String
    let description: String
    let minTemp: String
    let maxTemp: String
    let dayTemp: String
    let nightTemp: String
    let icon: String

    init(day: DailyWeather) {
        self.day = DateFormatterUtils.formattedDate(from: day.dt, format: "EEE d")
        self.description = day.weather.first?.description ?? "N/A"
        self.minTemp = "\(Int(day.temp.min))°"
        self.maxTemp = "\(Int(day.temp.max))°"
        self.dayTemp = "\(Int(day.temp.day))°"
        self.nightTemp = "\(Int(day.temp.night))°"
        self.icon = day.weather.first?.icon ?? ""
    }
}

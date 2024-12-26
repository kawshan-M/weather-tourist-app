//
//  WeatherViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeatherUI: [HourlyWeatherUI] = []
    @Published var dailyWeatherUI: [DailyWeatherUI] = []
//    @Published var hourlyWeather: [HourlyWeather] = []
//    @Published var dailyWeather: [DailyWeather] = []
    @Published var cityName: String = "Location"
    @Published var tempMin: String = "--"
    @Published var tempMax: String = "--"

    func fetchWeatherData(lat: Double, lon: Double) async {
        let apiKey = APIConfig.weatherAPIKey
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(WeatherDataModel.self, from: data)

            DispatchQueue.main.async {
                self.tempMin = "\(Int(decodedData.daily.first?.temp.min ?? 0))°"
                self.tempMax = "\(Int(decodedData.daily.first?.temp.max ?? 0))°"
                self.currentWeather = decodedData.current
                self.hourlyWeatherUI = decodedData.hourly.map { HourlyWeatherUI(hour: $0) }
                self.dailyWeatherUI = decodedData.daily.map { DailyWeatherUI(day: $0) }
            }
        } catch {
            print("Error fetching weather data: \(error)")
        }
    }
}

//
//  WeatherViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "--"
    @Published var description: String = "Loading..."
    @Published var cityName: String = "Location"

    func fetchWeatherData(lat: Double, lon: Double) async {
        let apiKey = APIConfig.weatherAPIKey
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                self.temperature = "\(Int(decodedData.main.temp))°C"
                self.description = decodedData.weather.first?.description.capitalized ?? ""
                self.cityName = decodedData.name
            }
        } catch {
            print("Error fetching weather data: \(error)")
        }
    }
}

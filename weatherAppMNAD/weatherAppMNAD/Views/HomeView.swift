//
//  HomeView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        VStack {
            Text(weatherVM.cityName)
                    .font(.largeTitle)
            WeatherCard(temperature: weatherVM.temperature, description: weatherVM.description)
           
            Spacer()
        }
        .task {
            await weatherVM.fetchWeatherData(lat: 6.9271, lon: 79.8612)
        }
    }
}

#Preview {
    HomeView()
}

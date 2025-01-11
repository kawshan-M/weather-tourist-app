//
//  HomeView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var airQualityVM = AirQualityViewModel()
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    @AppStorage("currentCity") var currentCity: String = "London"
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .transition(.opacity)
                    
//                    Image("background")
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea()
//                        .transition(.opacity)
                                        
                    
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 20){
                            VStack(spacing: 5){
                                if let current = weatherVM.currentWeather {
                                    Text(currentCity)
                                        .font(.largeTitle.bold())
                                        .foregroundColor(.white)
                                    
                                    Text("\(current.temp, specifier: "%.0f")°")
                                        .font(.system(size: 90, weight: .thin))
                                        .foregroundColor(.white)
                                    
                                    Text(currentDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("\(current.weather.first?.description ?? "N/A")")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                    
                                    Text("H:\(weatherVM.tempMax) L:\(weatherVM.tempMin)")
                                        .font(.body)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            .padding(.top, 5)
                            .task {
                                await weatherVM.fetchWeatherData(lat: latitude, lon: longitude)
                            }
                            
                            VStack(spacing: 10){
                                Text("Next 48 Hourly Forecast Weather for \(weatherVM.cityName)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                    .transition(.slide)
                                
                                Divider()
                                
                                ScrollView(.horizontal,showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(weatherVM.hourlyWeatherUI) { hour in
                                            WeatherCard(time: hour.time, temperature: hour.temperature, icon: hour.icon)
                                                .transition(.scale)
                                        }
                                    }
                                }
                            }
                            .padding(.top)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(20)
                            .transition(.move(edge: .leading))
                            
                            VStack(spacing: 10){
                                HStack {
                                    Image(systemName: "calendar")
                                        .font(.body)
                                    
                                    Text("8-DAY FORECAST")
                                        .font(.footnote)
                                    
                                    
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                .padding(.leading)
                                
                                VStack(spacing: 12){
                                    ForEach(weatherVM.dailyWeatherUI) { days in
                                        Divider()
                                        
                                        FiveDayForecastView(time: days.day, temperature: days.dayTemp, description: days.description, daytemp: days.dayTemp, nighttemp: days.nightTemp ,icon: days.icon)
                                    }
                                    
                                    
                                }
                            }
                            .padding(.top)
                            .padding(.bottom)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(20)
                            
                            if let current = weatherVM.currentWeather {
                                WindDataCard(wind: current.windSpeed, gusts: current.windGust, direction: current.windDeg)
                            }
                            
                            
                            HStack(spacing: 10){
                                if let current = weatherVM.currentWeather {
                                    HumidityCard(humidity: current.humidity, low: weatherVM.tempMin)
                                    
                                    AirPressureCard(pressure: current.pressure)
                                }
                            }
                            
                            VStack {
                                if let airQuality = airQualityVM.airQualityData {
                                    AirQualityCard(airQuality: airQuality)
                                }
                            }
                            .task {
                                await airQualityVM.fetchAirQuality(lat: latitude, lon: longitude)
                            }
                            
                            VStack {
                                Divider()
                                
                                NavigationLink(destination: MapView()) {
                                    HStack{
                                        Text("Open In Maps")
                                        Spacer()
                                        Image(systemName: "location.square.fill")
                                    }
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                }
                                
                                Divider()
                            }
                            
                            VStack{
                                Text("Weather for \(weatherVM.cityName)")
                                    .font(.body.bold())
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .toolbar {
                        NavigationLink(destination: PlacesView()) {
                            Image(systemName: "gear")
                                .tint(.black)
                        }
                    }
                }
                .onAppear{
                    print(latitude,longitude)
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}

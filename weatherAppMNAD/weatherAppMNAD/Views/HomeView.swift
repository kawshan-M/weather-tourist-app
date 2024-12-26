//
//  HomeView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @EnvironmentObject var viewModel: ViewModel
    @State private var selectedMark: City?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20){
                        VStack(spacing: 5){
                            //MY LOCATION
                            if let current = weatherVM.currentWeather {
                                Text("")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
          //need to fix this
                                Text("London")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                
                                Text("\(current.temp, specifier: "%.0f")°")
                                    .font(.system(size: 90, weight: .thin))
                                    .foregroundColor(.white)
                                
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
                            await weatherVM.fetchWeatherData(lat: 51.5074, lon: -0.1278)
                        }
                        
                        VStack(spacing: 10){
                            Text("Next 48 Hourly Forecast Weather for \(weatherVM.cityName)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                            
                            Divider()
                            
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack {
                                    ForEach(weatherVM.hourlyWeatherUI) { hour in
                                        WeatherCard(time: hour.time, temperature: hour.temperature)
                                    }
                                }
                            }
                        }
                        .padding(.top)
                        .background(.blue.opacity(0.2))
                        .cornerRadius(20)
                        
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
                                    
                                    FiveDayForecastView(time: days.day, temperature: days.dayTemp, description: days.description, daytemp: days.dayTemp, nighttemp: days.nightTemp)
                                }
                                
                                
                            }
                        }
                        .padding(.top)
                        .padding(.bottom)
                        .background(.blue.opacity(0.2))
                        .cornerRadius(20)
                        
//                        VStack(spacing: 10){
//                            Text("Cuurent Air Quality in \(weatherVM.cityName)")
//                                .font(.caption)
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.leading)
//                                .padding(.horizontal)
//                            
//                            Divider()
//                            
//                            HStack {
//                                ForEach(weatherVM.hourlyWeatherUI) { hour in
//                                    WeatherCard(time: hour.time, temperature: hour.temperature)
//                                }
//                            }
//                        }
//                        .padding(.top)
//                        .background(.blue.opacity(0.2))
//                        .cornerRadius(20)
                        
//                        VStack(spacing: 10){
//                            Text("Cuurent Wind speed in \(weatherVM.cityName)")
//                                .font(.caption)
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.leading)
//                                .padding(.horizontal)
//                            
//                            Divider()
//                            
//                            HStack {
//                                ForEach(weatherVM.hourlyWeatherUI) { hour in
//                                    WeatherCard(time: hour.time, temperature: hour.temperature)
//                                }
//                            }
//                        }
//                        .padding(.top)
//                        .background(.blue.opacity(0.2))
//                        .cornerRadius(20)

                    }
                }
                .padding()
                .toolbar {
                    NavigationLink(destination: PlacesView()) {
                        Image(systemName: "heart")
                            .tint(.black)
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(ViewModel())
}

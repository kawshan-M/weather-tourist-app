//
//  VisitedPlacesView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-26.
//

import SwiftUI
import MapKit

struct VisitedPlacesView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var locationVM: StoredPlacesViewModel
    @State var cityName: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToHome: Bool = false
    @State private var isNewLocation: Bool = false
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    @AppStorage("currentCity") var currentCity: String = "London"
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search for a city or airport", text: $cityName, onCommit: {
                    searchCity()
                })
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "mic.fill")
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.trailing, 10)
                    }
                )
                .padding(.horizontal, 16) 
                
                if !locationVM.favoriteCities.isEmpty {
                    List {
                        ForEach(locationVM.favoriteCities) { city in
                            Button(action: {
                                currentCity = city.name
                                latitude = city.latitude
                                longitude = city.longitude
                                navigateToHome = true
                            }) {
                                SavedCityCard(city: city.name, lat: city.latitude, lon: city.longitude)
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        }
                        .onDelete { indexSet in
                            locationVM.deleteCity(at: indexSet)
                        }
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
                
            }
            .navigationTitle("Weather")
            .toolbar {
                NavigationLink(destination: PlacesView()) {
                    Image(systemName: "gear")
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    cityName = ""
                    if alertMessage.contains("has been set") {
                        navigateToHome = true
                    }
                })
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
            }
        }
        .environment(\.colorScheme,.dark)
    }
    
    private func searchCity() {
        guard !cityName.isEmpty else {
            showAlert = true
            alertMessage = "Please enter a city name."
            return
        }
        
        if let existingCity = locationVM.favoriteCities.first(where: { $0.name.lowercased() == cityName.lowercased() }) {
            currentCity = existingCity.name
            latitude = existingCity.latitude
            longitude = existingCity.longitude
            showAlert = true
            alertMessage = "\(existingCity.name) is already in your favorite list and has been set as your current location. and geo-coordinates is not required"
            return
        }

        locationVM.searchForCity(query: cityName) { result in
            switch result {
            case .success(let mapItem):
                let coordinate = mapItem.placemark.coordinate
                currentCity = mapItem.name ?? cityName
                latitude = coordinate.latitude
                longitude = coordinate.longitude
                cityName = ""
                showAlert = true
                alertMessage = "The location \(currentCity) (Lat: \(latitude), Lon: \(longitude)) has been set as your current location."
            case .failure(let error):
                showAlert = true
                alertMessage = error.localizedDescription
                cityName = ""
            }
        }
    }
}

#Preview {
    VisitedPlacesView()
}

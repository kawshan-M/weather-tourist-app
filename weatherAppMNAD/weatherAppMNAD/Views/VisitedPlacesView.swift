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
    @EnvironmentObject var viewModel: ViewModel
    @State var cityName: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToHome: Bool = false
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search for a city", text: $cityName, onCommit: {
                    searchCity()
                })
                .textFieldStyle(.roundedBorder)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Spacer()
                        Image(systemName: "mic.fill")
                            .foregroundStyle(.gray)
                            .padding(.trailing, 10)
                    }
                )
                
                if !locationVM.favoriteCities.isEmpty {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(locationVM.favoriteCities) { city in
                                Button(action: {
                                    latitude = city.latitude
                                    longitude = city.longitude
                                    navigateToHome = true
                                }) {
                                    SavedCityCard(city: city.name, lat: city.latitude, lon: city.longitude)
                                }
                            }
                            .onDelete { indexSet in                                locationVM.deleteCity(at: indexSet)
                            }
                        }
                    }
                    
                    List {
                        ForEach(locationVM.favoriteCities) { city in
                            Button(action: {
                                latitude = city.latitude
                                longitude = city.longitude
                                navigateToHome = true
                            }) {
                                SavedCityCard(city: city.name, lat: city.latitude, lon: city.longitude)
                            }
                        }
                        .onDelete { indexSet in
                            locationVM.deleteCity(at: indexSet)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("Weather")
            .toolbar {
                NavigationLink(destination: PlacesView()) {
                    Image(systemName: "heart")
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    cityName = ""
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
        locationVM.searchForCity(query: cityName) { result in
            switch result {
            case .success(let mapItem):
                let coordinate = mapItem.placemark.coordinate
                latitude = coordinate.latitude
                longitude = coordinate.longitude
                cityName = ""
                navigateToHome = true
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
        .environmentObject(ViewModel())
}

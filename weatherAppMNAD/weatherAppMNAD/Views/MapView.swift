//
//  MapView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Namespace private var mapAnimation
    @StateObject private var viewModel = TouristPlacesViewModel()
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    @AppStorage("currentCity") var currentCity: String = "London"
    
    var body: some View {
        NavigationStack {
            VStack {
                Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.touristPlaces) { place in
                    MapMarker(coordinate: place.coordinate, tint: .red)
                }
                .frame(height: 300)
                .cornerRadius(15)
                .padding()
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .transition(.slide)
                .matchedGeometryEffect(id: "mapView", in: mapAnimation)
                
                Divider()

                Text("Top 5 Tourist Attractions in \(currentCity)")
                    .font(.title2.bold())
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.blue, Color.purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.horizontal)
                    .transition(.opacity)
                
                ScrollView {
                    ForEach(viewModel.touristPlaces) { place in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(place.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(place.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            LinearGradient(
                                colors: [Color.white, Color.blue.opacity(0.3)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                        .padding(.horizontal)
                        .transition(.scale)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.updateRegionAndFetchCityName(latitude: latitude, longitude: longitude)
            }
        }
    }
}

#Preview {
    MapView()
}


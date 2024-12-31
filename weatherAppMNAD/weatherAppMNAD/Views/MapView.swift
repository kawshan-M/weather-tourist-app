//
//  MapView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = TouristPlacesViewModel()
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    
    var body: some View {
        NavigationStack {
            VStack {
                // Map with Pins for Tourist Places
                Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.touristPlaces) { place in
                    MapMarker(coordinate: place.coordinate, tint: .red)
                }
                .frame(height: 300)
                .cornerRadius(15)
                .padding()

                Divider()

                // List of Tourist Places
                ScrollView {
                    ForEach(viewModel.touristPlaces) { place in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(place.name)
                                .font(.headline)
                            Text(place.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Map View")
            .onAppear {
                viewModel.updateRegionAndFetchCityName(latitude: latitude, longitude: longitude)
            }
        }
    }
}

#Preview {
    MapView()
}
//.navigationBarTitleDisplayMode(.inline)

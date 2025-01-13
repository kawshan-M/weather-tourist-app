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
    
    @State private var sheetHeight: CGFloat = 200
    @State private var isSheetExpanded: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Map View (Full Screen)
                Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.touristPlaces) { place in
                    MapMarker(coordinate: place.coordinate, tint: .red)
                }
                .edgesIgnoringSafeArea(.all)
                .transition(.slide)
                .matchedGeometryEffect(id: "mapView", in: mapAnimation)

                VStack(spacing: 0) {
                    Capsule()
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 10)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isSheetExpanded.toggle()
                                sheetHeight = isSheetExpanded ? UIScreen.main.bounds.height * 0.7 : 200
                            }
                        }

                    ScrollView {
                        VStack(alignment: .leading) {
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

                            ForEach(viewModel.touristPlaces) { place in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(place.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    HStack{
                                        Image(systemName: "mappin.and.ellipse")
                                            .foregroundStyle(.red)
                                        Text(place.address)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                                .padding(.horizontal)
                                .transition(.scale)
                            }
                        }
                    }
                }
                .frame(height: sheetHeight)
                .background(Color(.systemBackground).opacity(0.8))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newHeight = max(200, UIScreen.main.bounds.height - value.location.y)
                            sheetHeight = min(newHeight, UIScreen.main.bounds.height * 0.5)
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if sheetHeight > UIScreen.main.bounds.height * 0.4 {
                                    sheetHeight = UIScreen.main.bounds.height * 0.5
                                    isSheetExpanded = true
                                } else {
                                    sheetHeight = 200
                                    isSheetExpanded = false
                                }
                            }
                        }
                )
            }
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

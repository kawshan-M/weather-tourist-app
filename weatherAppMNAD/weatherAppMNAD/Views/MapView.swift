//
//  MapView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var selectedMark: City?
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            Map(selection: $selectedMark) {
                ForEach(Array(viewModel.selectedCities)) { city in
                    Marker(city.name, coordinate: city.coordinates)
                }
            }
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapView(selectedMark: .constant(.london))
        .environmentObject(ViewModel())
}

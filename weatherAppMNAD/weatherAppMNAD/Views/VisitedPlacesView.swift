//
//  VisitedPlacesView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-26.
//

import SwiftUI

struct VisitedPlacesView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @EnvironmentObject var viewModel: ViewModel
    @State private var selectedMark: City?
    @State var cityName: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("Search City", text: $cityName)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        viewModel.getCoordinateFrom(address: cityName)
                    }
                    
                NavigationLink(destination: MapView(selectedMark: $selectedMark)) {
                    Label("Pick from Favouires", systemImage: "location.circle")
                }
            }
            .padding()
            .toolbar {
                NavigationLink(destination: PlacesView()) {
                    Image(systemName: "heart")
                }
            }
        }
    }
}

#Preview {
    VisitedPlacesView()
        .environmentObject(ViewModel())
}

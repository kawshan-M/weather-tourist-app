//
//  ContentView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var selectedMark: City?
    @State var cityName: String = ""
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("Now")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            VisitedPlacesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Stored")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}

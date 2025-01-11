//
//  ContentView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import Network

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @AppStorage("selectedTab") private var selectedTab: Int = 0
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "cloud.sun.fill")
                                .font(.system(size: 20, weight: .medium))
                            Text("Now")
                                .font(.caption)
                        }
                    }
                    .tag(0)
                    .transition(.opacity)
                
                MapView()
                    .tabItem {
                        VStack {
                            Image(systemName: "map.fill")
                                .font(.system(size: 20, weight: .medium))
                            Text("Place Map")
                                .font(.caption)
                        }
                    }
                    .tag(1)
                    .transition(.slide)
                
                VisitedPlacesView()
                    .tabItem {
                        VStack {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 20, weight: .medium))
                            Text("Stored Places")
                                .font(.caption)
                        }
                    }
                    .tag(2)
                    .transition(.move(edge: .trailing))
            }
            .accentColor(.accentColor)
            .background(Color.white.ignoresSafeArea())
            .animation(.easeInOut, value: selectedTab)
            
            if !networkMonitor.isConnected {
                CheckInternetCard()
                    .transition(.scale)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NetworkMonitor())
}

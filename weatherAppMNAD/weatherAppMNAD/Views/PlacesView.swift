//
//  PlacesView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct PlacesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(City.allCases) { city in
                    HStack {
                        Text(city.name)
                        
                        Spacer()
                        
                        if viewModel.selectedCities.contains(city) {
                            Button {
                                viewModel.selectedCities.remove(city)
                            } label: {
                                Image(systemName: "xmark.circle")
                            }
                        } else {
                            Button {
                                viewModel.selectedCities.insert(city)
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PlacesView()
        .environmentObject(ViewModel())
}

//
//  PlacesView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct PlacesView: View {
    @AppStorage("isDark") var isLightMode: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Dark Mode")
                        .font(.title2.bold())
                    
                    Toggle(isOn: $isLightMode) {
                        
                    }
                }
                .padding()
                .padding(.top)
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    PlacesView()
}

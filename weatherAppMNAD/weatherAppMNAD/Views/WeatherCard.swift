//
//  WeatherCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct WeatherCard: View {
    let temperature: String
    let description: String
    
    var body: some View {
        VStack {
            Text(temperature)
                .font(.system(size: 48, weight: .bold))
            Text(description)
                .font(.title2)
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(12)
    }
    
}

//#Preview {
//    WeatherCard()
//}

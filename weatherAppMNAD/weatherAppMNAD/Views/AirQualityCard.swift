//
//  AirQualityCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct AirQualityCard: View {
//    let aqi: Int
    
    var body: some View {
        VStack {
            Text("Air Quality Index")
            Text("78")
                .font(.title)
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(12)
    }
}

#Preview {
    AirQualityCard()
}

//
//  WeatherCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct WeatherCard: View {
    let time: String
    let temperature: String
    
    var body: some View {
        VStack(spacing: 20){
            Text(time)
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Image(systemName: "cloud.fill")
                .font(.title2)
                .foregroundColor(.yellow)
            
            Text(temperature)
                .font(.body.bold())
                .foregroundColor(.white)
        }
        .padding()
    }
}

//#Preview {
//    WeatherCard()
//}

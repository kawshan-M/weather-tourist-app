//
//  AirQualityCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct AirQualityCard: View {
    let airQuality: AirQualityDetails?
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Image(systemName: "aqi.medium")
                    .font(.body)
                
                Text("Cuurent Air Quality in London")
                    .font(.footnote)
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading)
            
            Divider()
            
            HStack{
                VStack{
                    Image("so")
                        .resizable()
                    
                    Text(airQuality?.components.so2 != nil ? "\(airQuality!.components.so2, specifier: "%.2f")" : "N/A")
                        .foregroundStyle(.white)
                        .font(.body.bold())
                }
                .padding(.leading)
                
                VStack{
                    Image("no")
                        .resizable()
                    
                    Text(airQuality?.components.no != nil ? "\(airQuality!.components.no, specifier: "%.2f")" : "N/A")
                        .foregroundStyle(.white)
                        .font(.body.bold())
                }
                .padding(.leading)
                
                VStack{
                    Image("vo")
                        .resizable()
                    
                    Text(airQuality?.components.pm2_5 != nil ? "\(airQuality!.components.pm2_5, specifier: "%.2f")" : "N/A")
                        .foregroundStyle(.white)
                        .font(.body.bold())
                }
                .padding(.leading)
                
                VStack{
                    Image("pm")
                        .resizable()
                    
                    Text(airQuality?.components.pm10 != nil ? "\(airQuality!.components.pm10, specifier: "%.2f")" : "N/A")
                        .foregroundStyle(.white)
                        .font(.body.bold())
                }
                .padding(.leading)
            }
            .padding(.trailing)
            .padding(.vertical)

        }
        .padding(.top)
        .background(.blue.opacity(0.2))
        .cornerRadius(20)

    }
}

//#Preview {
//    AirQualityCard()
//}

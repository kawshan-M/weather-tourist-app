//
//  FiveDayForecastView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-26.
//

import SwiftUI

struct FiveDayForecastView: View {
    let time: String
    let temperature: String
    let description: String
    let daytemp: String
    let nighttemp: String
    let icon: String
    
    var body: some View {
        HStack{
            Text(time)
                .font(.body.bold())
                .foregroundColor(.white)
                .frame(width: 50, alignment: .leading)
                .padding(.leading)
            
            Spacer()
            
            VStack {
                Image(systemName: icon.toWeatherIcon())
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 30)
                
                Text(description)
                    .font(.caption2.bold())
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            HStack{
                VStack{
                    Text("Day")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 50, alignment: .leading)
                        .padding(.leading)
                    
                    Text(daytemp)
                        .font(.body.bold())
                        .foregroundColor(.white)
                }
                
                VStack{
                    Text("Night")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .frame(width: 50, alignment: .leading)
                        .padding(.leading)
                    
                    Text(daytemp)
                        .font(.body.bold())
                        .foregroundColor(.white)
                }
            }
            
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    FiveDayForecastView()
//}

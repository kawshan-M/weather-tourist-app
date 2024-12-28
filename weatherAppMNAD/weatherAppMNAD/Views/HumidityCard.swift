//
//  HumidityCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-27.
//

import SwiftUI

struct HumidityCard: View {
    let humidity: Int
    let low: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "humidity.fill")
                    .font(.body)
                
                Text("HUMIDITY")
                    .font(.footnote)
                    
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading)
            
            Divider()
            
            VStack(alignment: .leading){
                Text("\(humidity)%")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
                Text("The dew point is \(low) right now.")
                    .foregroundColor(.white)
                    .font(.body)
            }
            .padding(.bottom)
        }
        .padding(.top)
        .background(.blue.opacity(0.2))
        .cornerRadius(20)
    }
}

//#Preview {
//    HumidityCard()
//}

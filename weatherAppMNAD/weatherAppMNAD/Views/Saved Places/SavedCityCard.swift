//
//  SavedCityCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-30.
//

import SwiftUI

struct SavedCityCard: View {
    let city : String
    let lat : Double
    let lon : Double
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 110 / 255, green: 183 / 255, blue: 251 / 255),
                    Color(red: 46 / 255, green: 118 / 255, blue: 223 / 255)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 100)
            .cornerRadius(15)
            
            VStack(alignment: .leading){
                Text(city)
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                HStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text("Latitude")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        Text("Longitude")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8){
                        Text("\(lat)")
                            .font(.subheadline.bold())
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("\(lon)")
                            .font(.subheadline.bold())
                            .foregroundColor(.white.opacity(0.8))
                        
                    }
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    SavedCityCard()
//}

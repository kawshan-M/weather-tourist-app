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
//            Image(background)
//                .resizable()
//                .frame(height: 130)
//                .cornerRadius(15)
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                .frame(height: 100)
                .cornerRadius(15)
            
            VStack(alignment: .leading){
                Text(city)
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                HStack{
                    VStack{
                        Text("Latitude")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        Text("Longitude")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                    }
                    
                    Spacer()
                    
                    VStack{
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

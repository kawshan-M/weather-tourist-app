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
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .frame(height: 130)
                .cornerRadius(15)
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text(city)
                            .font(.title.bold())
                            .foregroundStyle(.white)
                        
                        Text("lat\(lat)")
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    Text("27")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                }
                
                HStack{
                    Text("lon\(lon)")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    Spacer()
                    Text("H:26 L:16")
                        .font(.subheadline.bold())
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    SavedCityCard()
//}

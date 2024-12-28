//
//  WindDataCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-27.
//

import SwiftUI

struct WindDataCard: View {
    let wind: Double
    let gusts: Double?
    let direction: Int
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Image(systemName: "wind")
                    .font(.body)
                
                Text("Wind")
                    .font(.footnote)
                    
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading)
            
            Divider()
            
            HStack{
                VStack{
                    HStack {
                        Text("Wind")
                            .font(.body.bold())
                            .foregroundColor(.white.opacity(0.8))
                        
                        Spacer()
                        
                        Text("\(wind, specifier: "%.2f") kmh")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Gusts")
                            .font(.body.bold())
                            .foregroundColor(.white.opacity(0.8))
                        
                        Spacer()
                        
                        Text(gusts != nil ? "\(gusts!, specifier: "%.2f") kmh" : "No data")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Direction")
                            .font(.body.bold())
                            .foregroundColor(.white.opacity(0.8))
                        
                        Spacer()
                        
                        Text("\(direction)°")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 10)
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 7)
                        .foregroundColor(.white.opacity(0.3))
                        .frame(width: 120, height: 120)
                                
                    Circle()
                        .trim(from: 0.0, to: 0.05)
                        .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round))
                        .foregroundColor(.red)
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(Double(direction))) // Rotate the pointer

                    VStack {
                        Text("\(wind, specifier: "%.2f")")
                            .font(.title.bold())
                            .foregroundColor(.white)
                        
                        Text("kmh")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()

        }
        .padding(.top)
        .background(.blue.opacity(0.2))
        .cornerRadius(20)
    }
}

//#Preview {
//    WindDataCard()
//}

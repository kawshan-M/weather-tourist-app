//
//  AirPressureCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-27.
//

import SwiftUI

struct AirPressureCard: View {
    let pressure: Int 
    let minPressure: Int = 950
    let maxPressure: Int = 1085

    var pressureProgress: Double {
        // Normalize pressure
        let range = Double(maxPressure - minPressure)
        let normalizedPressure = (Double(pressure) - Double(minPressure)) / range
        return normalizedPressure
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack {
                Image(systemName: "speedometer")
                    .font(.body)
                
                Text("PRESSURE")
                    .font(.footnote)
                    
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading)
            
            Divider()
            
            // Pressure Gauge
            VStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .foregroundColor(.white.opacity(0.3))
                        .frame(width: 110, height: 110)

                    Circle()
                        .trim(from: 0.0, to: pressureProgress)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .foregroundColor(.blue)
                        .frame(width: 110, height: 110)
                        .rotationEffect(.degrees(-90)) // Rotate the progress arc

                    VStack {
                        Text("\(pressure)")
                            .font(.title.bold())
                            .foregroundColor(.white)
                        
                        Text("hPa")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                HStack {
                    Text("Low")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    Text("High")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 20)
            }
            
        }
        .padding(.top)
        .background(.blue.opacity(0.2))
        .cornerRadius(20)
    }
}

//#Preview {
//    AirPressureCard()
//}

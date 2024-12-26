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
    
    var body: some View {
        HStack{
            Text(time)
                .font(.body.bold())
                .foregroundColor(.white)
                .frame(width: 50, alignment: .leading)
                .padding(.leading)
            
            Spacer()
            
            VStack {
                Image(systemName: "cloud.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 30)
                
                Text(description)
                    .font(.caption2.bold())
                    .foregroundColor(.white)
            }
//            .frame(width: 50, alignment: .leading)
            
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
            
//            HStack {
//                Text(daytemp)
//                    .font(.body.bold())
//                    .foregroundColor(.white)
//                
//                //                GeometryReader { geometry in
//                //                    ZStack(alignment: .leading) {
//                //                        Capsule()
//                //                            .fill(Color.white.opacity(0.3))
//                //                            .frame(height: 4)
//                //                        Capsule()
//                //                            .fill(Color.orange)
//                //                            .frame(width: geometry.size.width * CGFloat(0.5), height: 4)
//                //                    }
//                //                }
//                //                .frame(height: 4)
//                
//                Text(nighttemp)
//                    .font(.body.bold())
//                    .foregroundColor(.white)
//                    .padding(.trailing)
//                
//            }
//            .frame(width: 150)
            
        }
        .padding()
    }
}

//#Preview {
//    FiveDayForecastView()
//}

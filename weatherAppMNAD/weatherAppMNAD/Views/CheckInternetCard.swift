//
//  CheckInternetCard.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2025-01-02.
//

import SwiftUI

struct CheckInternetCard: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "wifi.slash")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                
                Text("No Internet Connection")
                    .font(.title)
                    .bold()
                
                Text("Please check your connection and try again.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    
                }) {
                    Text("Try Again")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            
            Spacer()
        }
        .background(.white)
    }
}

#Preview {
    CheckInternetCard()
}

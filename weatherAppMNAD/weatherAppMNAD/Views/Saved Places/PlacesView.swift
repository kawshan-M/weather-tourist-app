//
//  PlacesView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI

struct PlacesView: View {
    @AppStorage("isDark") var isLightMode: Bool = false
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Text("Dark Mode")
                        .font(.title2.bold())
                    
                    Toggle(isOn: $isLightMode) {
                        
                    }
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                Button(action: {
                    showLogoutAlert = true
                }) {
                    HStack {
                        Image(systemName: "power")
                            .foregroundColor(.red)
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Logout")) {
                        authVM.signOut()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    PlacesView()
}

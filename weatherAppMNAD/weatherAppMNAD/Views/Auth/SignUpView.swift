//
//  SignUpView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2025-01-12.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("back2")
                    .resizable()
                    .ignoresSafeArea()
                
                Color.black
                    .opacity(0.2)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 15){
                        HStack{
                            Spacer()
                            Image("logo")
                                .resizable()
                                .frame(width: 80, height: 80)
                            Spacer()
                        }
                        
                        Text("Create an account")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        TextField("Email", text: $email)
                            .padding()
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        Button(action: {
                            authVM.signUp(email: email, password: password)
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        if let errorMessage = authVM.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .alert(isPresented: $authVM.isSignUpSuccessful) {
                    Alert(
                        title: Text("Sign Up Successful"),
                        message: Text("Your account has been created successfully. Please log in."),
                        dismissButton: .default(Text("OK")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }

            }
        }
    }
}

#Preview {
    SignUpView()
}

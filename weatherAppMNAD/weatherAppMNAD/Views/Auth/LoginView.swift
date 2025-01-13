//
//  LoginView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2025-01-12.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("back2")
                    .resizable()
                    .ignoresSafeArea()
                
                Color.black
                    .opacity(0.2)
                    .ignoresSafeArea()
                                
                
                VStack{
                    
                    Spacer()
                    
                    VStack(spacing: 15) {
                        HStack{
                            Spacer()
                            Image("logo")
                                .resizable()
                                .frame(width: 80, height: 80)
                            Spacer()
                        }
                        
                        Text("Sign in to your account")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        SignInWithAppleButton(
                            .signIn,
                            onRequest: { request in
                                // Configure the request
                                request.requestedScopes = [.fullName, .email]
                            },
                            onCompletion: { result in
//                                switch result {
//                                case .success(let authorization):
//                                    handleAuthorization(authorization)
//                                case .failure(let error):
//                                    print("Sign in with Apple failed: \(error.localizedDescription)")
//                                }
                            }
                        )
                        .signInWithAppleButtonStyle(.whiteOutline) // Options: .black, .white, .whiteOutline
                        .frame(height: 45)
                        
                        HStack {
                            Spacer()
                            Text("Or continue with")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.vertical)
                                    
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
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                // Handle forgot password
                            }) {
                                Text("Forgot password?")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        
                        Button(action: {
                            authVM.signIn(email: email, password: password)
                        }) {
                            Text("Continue")
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
                        
                        HStack {
                            Text("Not a member?")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            NavigationLink("Create an account", destination: SignUpView())
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
                                    
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    LoginView()
}

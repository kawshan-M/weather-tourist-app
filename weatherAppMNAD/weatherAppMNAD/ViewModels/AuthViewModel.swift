//
//  AuthViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2025-01-11.
//

import Foundation
import FirebaseAuth
import Combine

class AuthViewModel : ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccessful = false
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.isAuthenticated = true
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.isSignUpSuccessful = true
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func checkAuthentication(){
        if Auth.auth().currentUser != nil {
            self.isAuthenticated = true
        }
    }
}

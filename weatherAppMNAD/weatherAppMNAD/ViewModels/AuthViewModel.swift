//
//  AuthViewModel.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2025-01-11.
//

import Foundation
import FirebaseAuth

class AuthViewModel : ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    
}

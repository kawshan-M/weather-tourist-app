//
//  ContentView.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2024-12-15.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    let db = Firestore.firestore()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            VStack {
                Text("Testing Firebase")
                    .font(.title)
                    .padding()
                
                Button(action: {
                    addDummyData()
                }) {
                    Text("Add Dummy Data")
                }
            }
        }
        .padding()
    }
    
    // Function to add dummy data to Firestore
    func addDummyData() {
        db.collection("testCollection").addDocument(data: [
            "name": "Test User",
            "age": 25
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  NetworkMonitor.swift
//  weatherAppMNAD
//
//  Created by Maleesha Kawshan on 2025-01-02.
//

import Foundation
import Network
import SwiftUI

class NetworkMonitor : ObservableObject {
    private var monitor: NWPathMonitor
    private let queue = DispatchQueue.global()
    @Published var isConnected: Bool = true
    
    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}

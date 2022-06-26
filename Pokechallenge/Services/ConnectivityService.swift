//
//  ConnectivityService.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import Foundation
import Network

class ConnectivityService: ObservableObject {
    @Published var connected: Bool = false
    let networkMonitor: NetworkMonitorProtocol

    init(networkMonitor: NetworkMonitorProtocol) {
        self.networkMonitor = networkMonitor
        checkConnection()
    }

    private func checkConnection() {
        networkMonitor.checkConnection { path in
            if path.status == .satisfied {
                self.connected = true
            } else {
                self.connected = false
            }
        }
    }
}

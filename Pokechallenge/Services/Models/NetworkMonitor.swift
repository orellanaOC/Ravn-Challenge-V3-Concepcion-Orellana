//
//  NetworkMonitor.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import Foundation
import Network

protocol NetworkMonitorProtocol {
    func checkConnection(updateHandler: @escaping (NWPath) -> Void)
}

struct NetworkMonitor: NetworkMonitorProtocol {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")

    func checkConnection(updateHandler: @escaping (NWPath) -> Void) {
        monitor.pathUpdateHandler = updateHandler
        monitor.start(queue: queue)
    }
}

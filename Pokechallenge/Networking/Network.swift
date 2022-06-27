//
//  Network.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/21/22.
//

import Apollo
import CoreData

class Network {
    private(set) lazy var apollo = ApolloClient(url: Constants.baseUrl)
    static let shared = Network()
    private init() { }
}

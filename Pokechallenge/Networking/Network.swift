//
//  Network.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/21/22.
//

import Apollo
import CoreData

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: Constants.baseUrl)!)
    private init() { }
}

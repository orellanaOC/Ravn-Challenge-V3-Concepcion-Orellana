//
//  PokemonServiceFactory.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/24/22.
//

import Foundation

enum PokemonServiceFactory {
    static func newService() -> PokemonServiceProtocol {
        PokemonService(
            provider: NetworkProvider(),
            decoder: JSONDecoder()
        )
    }
}

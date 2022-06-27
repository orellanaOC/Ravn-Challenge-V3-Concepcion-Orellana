//
//  PokemonServiceMock.swift
//  PokechallengeTests
//
//  Created by Concepcion Orellana on 6/27/22.
//

import Foundation
import Combine

@testable import Pokechallenge

struct PokemonServiceMock: PokemonServiceProtocol {
    let shouldGetPokemonFail: Bool
    var isTherePokemonID: Bool = false

    func getDetail(for pokemonID: Int) -> AnyPublisher<Pokemon, Error> {
        if isTherePokemonID {
            return Fail(error: NSError(domain: "Error to Load Data", code: 2))
                .eraseToAnyPublisher()
        } else {
            return Just(
                Pokemon.pokemonTest
            )
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }

    func getAll() -> AnyPublisher<[PokemonSearch], Error> {
        if shouldGetPokemonFail {
            return Fail(error: NSError(domain: "Connection lost", code: 1))
                .eraseToAnyPublisher()
        } else {
            return Just(
                PokemonSearch.pokemonListTest
            )
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
}

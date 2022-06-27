//
//  PokemonDetailViewModelTests.swift
//  PokechallengeTests
//
//  Created by Concepcion Orellana on 6/27/22.
//

import XCTest
import Combine

@testable import Pokechallenge

class PokemonDetailViewModelTests: XCTestCase {
    func testGetPokemon() {
        // Given
        let service = PokemonServiceMock(shouldGetPokemonFail: false)
        let viewModel = PokemonDetailViewModel(
            pokemonID: 25,
            pokemonService: service,
            connectivity: ConnectivityService(networkMonitor: NetworkMonitor())
        )
        var cancellable = Set<AnyCancellable>()
        var pokemons: [Pokemon] = []

        // When
        viewModel.$pokemon
            .dropFirst()
            .sink { pokemon in
                pokemons.append(pokemon)
        }
        .store(in: &cancellable)
        viewModel.getPokemon()

        // Then
        XCTAssertEqual(pokemons, [Pokemon.pokemonTest])
        XCTAssertNotNil(cancellable)
    }

}

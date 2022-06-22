//
//  PokemonListViewModel.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/21/22.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonSearch] = []
    @Published var isLoading = false
    var generation: [String] = []

    let pokemonService: PokemonServiceProtocol

    init(pokemonService: PokemonServiceProtocol) {
        self.pokemonService = pokemonService
    }

    func loadData() {
        isLoading = true

        var generations: Set<String> = []

        pokemonService.getAll { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let pokemons):
                    self?.pokemons = pokemons
                        pokemons.forEach { generations.insert($0.generation) }
                        generations.forEach { self?.generation.append($0) }
                        self?.generation.sort()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

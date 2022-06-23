//
//  PokemonListViewModel.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/21/22.
//

import Combine
import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonSearch] = []
    @Published var pokemonsFiltered: [PokemonSearch] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage: String?

    let pokemonService: PokemonServiceProtocol
    var generation: [String] = []
    var allGenerations: Set<String> = []
    var cancellable = Set<AnyCancellable>()

    init(pokemonService: PokemonServiceProtocol) {
        self.pokemonService = pokemonService
    }

    func loadData() {
        isLoading = true

        pokemonService.getAllPokemon()
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        self.isLoading = false
                        self.isError = true
                        self.errorMessage = NSString(string: error.localizedDescription)
                            .components(separatedBy: ". ")
                            .first
                    }
                }, receiveValue: { [weak self] pokemons in
                    self?.isLoading = false
                    self?.pokemons = pokemons
                    self?.pokemonsFiltered = pokemons
                    self?.getGenerations()
                }
            )
            .store(in: &cancellable)
    }

    func filterPokemons(by searchText: String? = nil) {
        if let searchText = searchText {
            pokemonsFiltered = pokemons.filter { $0.name.contains(searchText.lowercased()) }
        } else {
            pokemonsFiltered = pokemons
        }
        getGenerations()
    }

    private func getGenerations() {
        allGenerations.removeAll()
        generation.removeAll()
        pokemonsFiltered.forEach { allGenerations.insert($0.generation) }
        allGenerations.forEach { generation.append($0) }
        generation.sort()
    }
}

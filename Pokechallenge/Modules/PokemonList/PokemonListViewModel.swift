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
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var isErrorToLoadData = false
    @Published var isShowingConnectionLost = false

    var isShowGeneration: Bool {
        generation.count > 1 ? true : false
    }

    let pokemonService: PokemonServiceProtocol
    let connectivity: ConnectivityService
    var generation: [String] = []
    var allGenerations: Set<String> = []
    var cancellable = Set<AnyCancellable>()

    init(pokemonService: PokemonServiceProtocol, connectivity: ConnectivityService) {
        self.pokemonService = pokemonService
        self.connectivity = connectivity

        loadData()
        bindings()
    }

    private func bindings() {
        $searchText
            .sink { [weak self] _ in
                self?.filterPokemons()
            }
            .store(in: &cancellable)

        connectivity.$connected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] connected in
                self?.isShowingConnectionLost = !connected
            }
            .store(in: &cancellable)
    }

    func loadData() {
        isLoading = true

        pokemonService.getAll()
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        self.isLoading = false
                        self.isShowingError = true
                        self.errorMessage = NSString(string: error.localizedDescription)
                            .components(separatedBy: ". ")
                            .first
                    default: break
                    }
                    self.isLoading = false
                }, receiveValue: { [weak self] pokemons in
                    self?.pokemons = pokemons
                    self?.pokemonsFiltered = pokemons
                    self?.getGenerations()
                }
            )
            .store(in: &cancellable)
    }

    private func filterPokemons() {
        if !searchText.isEmpty {
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

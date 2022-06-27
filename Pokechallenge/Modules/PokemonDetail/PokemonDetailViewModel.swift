//
//  PokemonDetailViewModel.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Combine
import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon = .example
    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var spriteTypeSelected: Int = .zero
    @Published var isShowingConnectionLost = false

    let pokemonID: Int
    let pokemonService: PokemonServiceProtocol
    let connectivity: ConnectivityService
    var cancellable = Set<AnyCancellable>()

    init(pokemonID: Int, pokemonService: PokemonServiceProtocol, connectivity: ConnectivityService) {
        self.pokemonID = pokemonID
        self.pokemonService = pokemonService
        self.connectivity = connectivity

        bindings()
    }

    // MARK: - Check the status of the internet connection

    func bindings() {
        connectivity.$connected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] connected in
                self?.isShowingConnectionLost = !connected
            }
            .store(in: &cancellable)
    }

    // MARK: - API Request

    func getPokemon() {
        isLoading = true
        pokemonService.getDetail(for: pokemonID)
            .compactMap { $0 }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        self.isShowingError = true
                        self.errorMessage = NSString(string: error.localizedDescription)
                            .components(separatedBy: ". ")
                            .first
                    default: break
                    }
                    self.isLoading = false
                },
                receiveValue: { [weak self] pokemon in
                    self?.pokemon = pokemon
                }
            )
            .store(in: &cancellable)
    }
}

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

    let pokemonID: Int
    let pokemonService: PokemonServiceProtocol
    var cancellable = Set<AnyCancellable>()

    init(pokemonID: Int, pokemonService: PokemonServiceProtocol) {
        self.pokemonID = pokemonID
        self.pokemonService = pokemonService
    }

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

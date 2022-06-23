//
//  PokemonService.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/21/22.
//

import Apollo
import Combine
import Foundation

protocol PokemonServiceProtocol {
    func getAllPokemon() -> AnyPublisher<[PokemonSearch], Error>
}

 struct PokemonService: PokemonServiceProtocol {
     var connection: Network = .shared

    func getAllPokemon() -> AnyPublisher<[PokemonSearch], Error> {
        Future { promise in
            DispatchQueue.main.async {
                connection.apollo.fetch(query: AllPokemonQuery()) { result in
                    switch result {
                    case .success(let graphQLResult):
                        if let pokemonList = graphQLResult.data?.allPokemon {
                            let pokemons = pokemonList.map { data in
                                PokemonSearch(
                                    id: data?.id ?? 0,
                                    name: data?.name ?? "",
                                    generation: data?.generation ?? "",
                                    genus: data?.genus ?? "",
                                    flavours: data?.types?.map { Flavour(name: $0?.name ?? "") } ?? [],
                                    sprites: data?.sprites?.frontDefault ?? ""
                                )
                            }
                           promise(.success(pokemons))
                        }
                    case .failure(let error):
                            promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
 }

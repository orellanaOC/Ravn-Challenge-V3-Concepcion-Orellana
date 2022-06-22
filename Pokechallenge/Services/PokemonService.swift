//
//  PokemonService.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/21/22.
//

import Apollo
import Combine

protocol PokemonServiceProtocol {
    func getAll(completion: @escaping (Result<[PokemonSearch], Error>) -> Void )
}

struct PokemonService: PokemonServiceProtocol {
    func getAll(completion: @escaping (Result<[PokemonSearch], Error>) -> Void ) {
        Network.shared.apollo.fetch(query: AllPokemonQuery()) { result in
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
                    completion(.success(pokemons))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

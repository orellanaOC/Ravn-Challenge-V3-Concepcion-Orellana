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
    func getDetail(for pokemonID: Int) -> AnyPublisher<Pokemon, Error>
    func getAll() -> AnyPublisher<[PokemonSearch], Error>
}

struct PokemonService: PokemonServiceProtocol {
    let provider: NetworkProviderType
    let decoder: JSONDecoder
    let base = Constants.urlDetail
    var connection: Network = .shared

    func getDetail(for pokemonID: Int) -> AnyPublisher<Pokemon, Error> {
        getPokemonEvolution(by: pokemonID)
            .flatMap { detail in
                getSinglePokemon(by: pokemonID)
                    .map { pokemon in
                        (pokemon, detail)
                    }
            }
            .map { values in
                Pokemon(
                    id: values.0.id,
                    name: values.0.name,
                    generation: values.1.generation,
                    color: values.0.color.name,
                    isLegendary: values.0.isLegendary,
                    flavours: values.1.flavours,
                    sprites: values.1.sprites,
                    evolutions: values.1.evolutions,
                    description: values.1.description
                )
            }
            .eraseToAnyPublisher()
    }

    private func getSinglePokemon(by pokemonID: Int) -> AnyPublisher<Characteristic, Error> {
        let components = URLComponents(url: base, resolvingAgainstBaseURL: true)

        guard let requestUrl = components?.url else {
            return Fail(error: PokemonServiceError.invalidUrl)
                .eraseToAnyPublisher()
        }

        let request = URLRequest(
            url: requestUrl.appendingPathComponent("pokemon-species/\(pokemonID)")
        )

        return provider.run(request, decoder)
            .map(\.value)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func getPokemonEvolution(by pokemonID: Int) -> AnyPublisher<PokemonDetail, Error> {
        Future { promise in
            DispatchQueue.main.async {
                connection.apollo.fetch(query: SinglePokemonQuery(pokeId: pokemonID)) { result in
                    switch result {
                    case .success(let graphQLResult):
                        if let pokemonFetch = graphQLResult.data?.pokemon {
                            let pokemon: PokemonDetail = .init(
                                id: pokemonFetch.id ?? -1,
                                generation: pokemonFetch.generation ?? "",
                                flavours: pokemonFetch.types?
                                    .map {
                                        var flavour = Flavour(name: "")
                                        if !String(describing: $0?.name ?? "").isEmpty {
                                            let name = String(describing: $0?.name ?? "")
                                            flavour.name = "\(name)Tag"
                                        }
                                        return flavour
                                    }
                                ?? [],
                                sprites: Sprite(
                                    frontDefault: pokemonFetch.sprites?.frontDefault ?? "",
                                    frontShiny: pokemonFetch.sprites?.frontShiny ?? ""
                                ),
                                evolutions: pokemonFetch.evolvesTo?
                                    .map {
                                        Evolution(
                                            id: $0?.id ?? -1,
                                            name: $0?.name ?? "",
                                            sprites: $0?.sprites?.frontDefault ?? ""
                                        )
                                    } ?? [],
                                description: pokemonFetch.pokedexEntries?
                                    .first??.description?.lowercased() ?? ""
                            )
                            promise(.success(pokemon))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getAll() -> AnyPublisher<[PokemonSearch], Error> {
        Future { promise in
            DispatchQueue.main.async {
                connection.apollo.fetch(query: AllPokemonQuery()) { result in
                    switch result {
                    case .success(let graphQLResult):
                        if let pokemonList = graphQLResult.data?.allPokemon {
                            let pokemons = pokemonList
                                .map { data in
                                    PokemonSearch(
                                        id: data?.id ?? 0,
                                        name: data?.name ?? "",
                                        generation: data?.generation ?? "",
                                        genus: data?.genus ?? "",
                                        flavours: data?.types?
                                            .map {
                                                Flavour(name: $0?.name ?? "")
                                            } ?? [],
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

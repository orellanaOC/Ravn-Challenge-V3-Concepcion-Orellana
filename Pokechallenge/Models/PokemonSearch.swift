//
//  Pokemon.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import Foundation

struct PokemonSearch: Identifiable, Codable {
    let id: Int
    let name: String
    let generation: String
    let genus: String
    let flavours: [Flavour]
    let sprites: String
}

extension PokemonSearch {
    static let example = PokemonSearch(
        id: -1,
        name: "",
        generation: "",
        genus: "",
        flavours: [],
        sprites: ""
    )

    static let pokemonListTest = [
        PokemonSearch(
            id: 25,
            name: "Pikachu",
            generation: "Generation I",
            genus: "Mouse Pokémon",
            flavours: [
                .init(name: "Electric")
            ],
            sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
        )
    ]
}

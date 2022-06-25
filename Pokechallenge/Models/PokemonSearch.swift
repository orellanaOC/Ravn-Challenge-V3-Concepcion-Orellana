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
    static let pokemonDefault: PokemonSearch = .init(
        id: 1, name: "Pokemon X",
        generation: "Generation I",
        genus: "",
        flavours: [],
        sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/810.png"
    )
}

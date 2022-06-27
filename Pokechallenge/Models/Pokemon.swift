//
//  Pokemon.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Foundation

struct Pokemon: Identifiable, Codable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }

    let id: Int
    let name: String
    let generation: String
    let color: String
    let isLegendary: Bool
    let flavours: [Flavour]
    let sprites: Sprite
    let evolutions: [Evolution]
    let description: String
}

extension Pokemon {
    static let example = Pokemon(
        id: -1,
        name: "",
        generation:  "",
        color:  "",
        isLegendary: false,
        flavours: [],
        sprites: .init(
            frontDefault:  "",
            frontShiny:  ""
        ),
        evolutions: [],
        description: ""
    )

    static let pokemonTest = Pokemon(
        id: 25,
        name: "Pikachu",
        generation: "Generation I",
        color: "yellow",
        isLegendary: false,
        flavours: [
            .init(name: "Electric")
        ],
        sprites: Sprite(
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png"
        ),
        evolutions: [
            Evolution(
                id: 26,
                name: "raichu",
                sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/26.png"
            )
        ],
        description: "When several of these POKéMON gather, their electricity could build and cause lightning storms."
    )
}

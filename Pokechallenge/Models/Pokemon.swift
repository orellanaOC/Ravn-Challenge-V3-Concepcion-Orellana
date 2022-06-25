//
//  Pokemon.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Foundation

struct Pokemon: Identifiable, Codable {
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
    static let example: Pokemon = .init(
        id: 1,
        name: "Pokemon X",
        generation:  "Generation I",
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
}

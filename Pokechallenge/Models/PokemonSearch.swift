//
//  Pokemon.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import Foundation

struct PokemonSearch: Identifiable {
    let id: Int
    let name: String
    let generation: String
    let genus: String
    let flavours: [Flavour]
    let sprites: String
}

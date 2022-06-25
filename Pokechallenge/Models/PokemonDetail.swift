//
//  PokemonDetail.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Foundation

struct PokemonDetail: Identifiable, Codable {
    let id: Int
    let generation: String
    let genus: String
    let flavours: [Flavour]
    let sprites: Sprite
    let evolutions: [Evolution]
    let description: String
}

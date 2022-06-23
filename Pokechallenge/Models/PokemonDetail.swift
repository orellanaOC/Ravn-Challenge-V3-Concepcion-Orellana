//
//  PokemonDetail.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Foundation

struct PokemonDetail: Identifiable, Codable {
    let id: Int
    let name: String
    let generation: String
    let color: String
    let genus: String
    let flavours: [Flavour]
    let sprites: Sprite
    let evolutions: [PokemonEvolution]
    let description: String
}

//
//  Pokemon.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import Foundation

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let generation: String
    let sprite: String
    let flavours: [Flavour]
}

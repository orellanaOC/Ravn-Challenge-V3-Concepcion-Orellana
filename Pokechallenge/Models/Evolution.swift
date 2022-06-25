//
//  Evolution.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Foundation

struct Evolution: Identifiable, Codable {
    let id: Int
    let name: String
    let sprites: String
}

extension Evolution {
    static let example = Evolution(
        id: -1,
        name: "",
        sprites: ""
    )
}

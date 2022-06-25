//
//  Flavour.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import Foundation

struct Flavour: Identifiable, Codable {
    var name: String

    var id: String {
        name
    }
}

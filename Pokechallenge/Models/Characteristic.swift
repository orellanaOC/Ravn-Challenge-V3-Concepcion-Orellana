//
//  Characteristic.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/24/22.
//

import Foundation

struct Characteristic: Codable {
    let id: Int
    let name: String
    let color: Color

    struct Color: Codable {
        let name: String
        let url: String
    }
}

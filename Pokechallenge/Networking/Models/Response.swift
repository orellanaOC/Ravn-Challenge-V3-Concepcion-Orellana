//
//  Response.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/23/22.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
}

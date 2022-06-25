//
//  PokemonNameView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct PokemonNameView: View {
    let id: String
    let name: String

    var body: some View {
        Group {
            Text(name)
                .font(
                    .headline
                        .weight(.bold)
                )

            Text(id)
                .font(
                    .headline
                        .weight(.light)
                )
        }
    }
}

struct PokemonNameView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonNameView(id: "", name: "")
    }
}

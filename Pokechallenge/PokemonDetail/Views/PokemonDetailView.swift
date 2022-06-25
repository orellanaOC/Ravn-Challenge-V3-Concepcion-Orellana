//
//  PokemonDetailView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    var body: some View {
        ZStack(alignment: .top) {
            Color("PokemonCard")
            VStack {
                if pokemon.id != -1 {
                Text("#\(pokemon.id) \(pokemon.name)")
                    .font(
                        .title
                            .weight(
                                .regular
                            )
                    )
                    .padding()
                }

                HStack(alignment: .center, spacing: DrawingConstants.measure10) {
                    ForEach(pokemon.flavours) { flavour in
                        Image(flavour.name)
                            .padding(
                                .init(
                                    top: -DrawingConstants.measure10,
                                    leading: -DrawingConstants.measure10,
                                    bottom: -DrawingConstants.measure10,
                                    trailing: -DrawingConstants.measure10
                                )
                            )
                    }
                }
                .padding(.trailing)
            }
        }
        .cornerRadius(25, corners: [.topLeft, .topRight])
    }

    private struct DrawingConstants {
        static let measure0: CGFloat = .zero
        static let measure5: CGFloat = 5
        static let measure10: CGFloat = 10
        static let measure15: CGFloat = 15
        static let measure20: CGFloat = 20
        static let measure30: CGFloat = 30
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: .example)
    }
}

//
//  PokemonView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import Kingfisher
import SwiftUI

struct PokemonView: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: DrawingConstants.measure15)
                .fill()
                .foregroundColor(Color("PokemonCard"))
                .padding(
                    .init(
                        top: DrawingConstants.measure0,
                        leading: DrawingConstants.measure20,
                        bottom: DrawingConstants.measure0,
                        trailing: DrawingConstants.measure0
                    )
                )

            HStack {
                KFImage(URL(string: pokemon.sprite))
                    .padding(
                        .init(
                            top: -DrawingConstants.measure30,
                            leading: -DrawingConstants.measure30,
                            bottom: -DrawingConstants.measure30,
                            trailing: -DrawingConstants.measure30
                        )
                    )

                VStack(alignment: .leading) {
                    Text(pokemon.name)
                        .font(
                            .headline
                                .weight(
                                    .bold
                                )
                        )

                    Text("#\(pokemon.id)")
                        .font(
                            .headline
                                .weight(
                                    .light
                                )
                        )
                }

                Spacer()

                Spacer()

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
            .padding(
                .init(
                    top: DrawingConstants.measure15,
                    leading: DrawingConstants.measure0,
                    bottom: DrawingConstants.measure15,
                    trailing: DrawingConstants.measure0
                )
            )

        }
        .padding(
            .init(
                top: DrawingConstants.measure5,
                leading: DrawingConstants.measure0,
                bottom: DrawingConstants.measure0,
                trailing: DrawingConstants.measure0
            )
        )
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

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(
            pokemon: .init(
                id: 1, name: "Poke",
                generation: Generation.generationI.rawValue,
                sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/810.png",
                flavours: [Flavour.init(name: "Grass")]
            )
        )
    }
}

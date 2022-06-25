//
//  PokemonDetailView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct PokemonDetailView: View {
    let isLoading: Bool
    let pokemon: Pokemon

    var body: some View {
        if pokemon.id != -1 {
            ZStack(alignment: .top) {
                Color("Evolution")

                VStack {
                    Text("#\(pokemon.id) \(pokemon.name)")
                        .font(
                            .title
                                .weight(.regular)
                        )
                        .padding()

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

                    Text(pokemon.generation)
                        .font(
                            .headline
                                .weight(.regular)
                        )
                        .padding()

                    Text(pokemon.description)
                        .font(
                            .subheadline
                                .weight(.regular)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.horizontal)

                    if pokemon.evolutions.count > .zero {
                        Divider()

                        ZStack {
                            EvolutionListView(
                                isLoading: isLoading,
                                pokemon: pokemon
                            )

                            Progress(isLoading: isLoading)
                        }
                    }
                }
            }
            .cornerRadius(
                DrawingConstants.measure25,
                corners: [.topLeft, .topRight]
            )
        }
    }

    private struct DrawingConstants {
        static let measure10: CGFloat = 10
        static let measure25: CGFloat = 25
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(
            isLoading: false,
            pokemon: .example
        )
    }
}

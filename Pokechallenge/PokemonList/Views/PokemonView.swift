//
//  PokemonView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import Kingfisher
import SwiftUI

struct PokemonView: View {
    @State private var isActivated = false

    let pokemon: PokemonSearch

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
                KFImage(URL(string: pokemon.sprites))
                    .padding(
                        .init(
                            top: -DrawingConstants.measure30,
                            leading: -DrawingConstants.measure15,
                            bottom: -DrawingConstants.measure30,
                            trailing: -DrawingConstants.measure0
                        )
                    )

                VStack(alignment: .leading) {
                    HStack {
                        if pokemon.genus.contains("Legendary") {
                            Image("Legendary")
                                .padding(
                                    .init(
                                        top: -DrawingConstants.measure10,
                                        leading: -DrawingConstants.measure10,
                                        bottom: -DrawingConstants.measure10,
                                        trailing: DrawingConstants.measure0
                                    )
                                )
                        }

                        Text(pokemon.name)
                            .font(
                                .headline
                                    .weight(
                                        .bold
                                    )
                            )
                    }

                    Text("#\(pokemon.id)")
                        .font(
                            .headline
                                .weight(
                                    .light
                                )
                        )
                }

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
                    top: DrawingConstants.measure20,
                    leading: DrawingConstants.measure0,
                    bottom: DrawingConstants.measure20,
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
        .onTapGesture {
            isActivated = true
        }
        .background(
            NavigationLink(
                destination: PokemonDetailView(
                    viewModel: PokemonDetailViewModel(
                        pokemonID: pokemon.id,
                        pokemonService: PokemonServiceFactory.newService()
                    )
                ),
                isActive: $isActivated) { EmptyView() }
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
        PokemonView(pokemon: .pokemonDefault)
    }
 }

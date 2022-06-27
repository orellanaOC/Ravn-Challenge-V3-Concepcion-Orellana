//
//  EvolutionView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import Kingfisher
import SwiftUI

struct EvolutionView: View {
    @State private var isActivated = false

    let pokemon: Pokemon
    let evolution: Evolution

    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                VStack {
                    PokemonImageView(image: pokemon.sprites.frontDefault)

                    PokemonNameView(id: "#\(pokemon.id)", name: pokemon.name)
                }

                VStack {
                    PokemonImageView(image: evolution.sprites)
                        .onTapGesture {
                            isActivated = true
                        }
                        .background(
                            NavigationLink(
                                destination: PokemonInfoView(
                                    viewModel: PokemonDetailViewModel(
                                        pokemonID: evolution.id,
                                        pokemonService: PokemonServiceFactory.newService(),
                                        connectivity: ConnectivityService(networkMonitor: NetworkMonitor())
                                    )
                                ),
                                isActive: $isActivated
                            ) { EmptyView() }
                                .hidden()
                        )

                    PokemonNameView(id: "#\(evolution.id)", name: evolution.name)
                }
            }
            .padding(.horizontal)

            Image(systemName: "arrow.right")
                .foregroundColor(.gray)
        }
    }
}

struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionView(
            pokemon: .example,
            evolution: .example
        )
    }
}

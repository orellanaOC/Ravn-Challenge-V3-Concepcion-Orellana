//
//  PokemonListView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.generation, id: \.self) { generation in
                    if !viewModel.isLoading {
                        GenerationView(
                            generation: generation,
                            pokemons: viewModel.pokemons
                        )
                    }
                }
                .listStyle(.plain)
                .onAppear {
                    UITableView
                        .appearance()
                        .separatorColor = .clear

                    viewModel.loadData()
                }
                .navigationTitle(
                    Text("Pokemon List")
                )
            }

            Progress(isLoading: viewModel.isLoading)
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(viewModel: PokemonListViewModel(pokemonService: PokemonService()))
    }
}

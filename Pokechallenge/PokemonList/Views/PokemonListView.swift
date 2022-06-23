//
//  PokemonListView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    @State private var searchText = ""
    @State private var pokemonsFiltered: [PokemonSearch] = []

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.generation, id: \.self) { generation in
                    if !viewModel.isLoading,
                       !viewModel.pokemons.isEmpty {
                        GenerationView(
                            isShowGeneration: viewModel.generation.count > 1 ? true : false,
                            generation: generation,
                            pokemons: searchText.isEmpty ? viewModel.pokemons : viewModel.pokemonsFiltered
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
                .alert(isPresented: $viewModel.isError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ?? ""),
                        dismissButton:
                                .default(
                                    Text("Ok"),
                                    action: { viewModel.loadData() }
                                )
                    )
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .onChange(of: searchText) { searchText in
                if !searchText.isEmpty {
                    viewModel.filterPokemons(by: searchText)
                }
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

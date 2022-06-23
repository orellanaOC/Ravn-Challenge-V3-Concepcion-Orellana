//
//  PokemonListView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    @State private var isErrorToLoadData = false
    @State private var searchText = ""
    @State private var pokemonsFiltered: [PokemonSearch] = []

    var body: some View {
        ZStack {
            NavigationView {
                if !searchText.isEmpty,
                    isErrorToLoadData {
                    VStack(alignment: .center) {
                        Text("Failed to Load Data")
                            .font(
                                .footnote
                                    .weight(
                                        .light
                                    )
                            )
                            .foregroundColor(.red)

                        Spacer()
                    }
                } else {
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

                        if viewModel.isError, viewModel.pokemons.isEmpty {
                            isErrorToLoadData = true
                        }
                    }
                    .navigationTitle(
                        Text("Pokemon List")
                    )
                    .alert(isPresented: $viewModel.isError) {
                        Alert(title: Text("Error"),
                              message: Text(viewModel.errorMessage ?? "Failed to Load Data"),
                              primaryButton:
                                .default(
                                    Text("Try Again"),
                                    action: { viewModel.loadData() }
                                ),
                              secondaryButton:
                                .cancel { isErrorToLoadData = true }
                        )
                    }
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

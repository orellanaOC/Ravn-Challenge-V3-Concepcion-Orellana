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
                ZStack {
                    List(viewModel.generation, id: \.self) { generation in
                        if !viewModel.isLoading,
                           !viewModel.pokemons.isEmpty {
                            GenerationView(
                                isShowGeneration: viewModel.isShowGeneration,
                                generation: generation,
                                pokemons: viewModel.searchText.isEmpty ?
                                viewModel.pokemons :
                                    viewModel.pokemonsFiltered
                            )
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        UITableView
                            .appearance()
                            .separatorColor = .clear

                        if viewModel.isShowingError,
                            viewModel.pokemons.isEmpty {
                            viewModel.isErrorToLoadData = true
                        }
                    }
                    .navigationTitle(
                        Text("Pokemon List")
                    )
                    .alert(isPresented: $viewModel.isShowingError) {
                        Alert(title: Text("Error"),
                              message: Text(viewModel.errorMessage ?? "Failed to Load Data"),
                              primaryButton:
                                .default(
                                    Text("Try Again"),
                                    action: { viewModel.loadData() }
                                ),
                              secondaryButton:
                                .cancel { viewModel.isErrorToLoadData = true }
                        )
                    }

                    if viewModel.isErrorToLoadData {
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
                    }
                }
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )

            Progress(isLoading: viewModel.isLoading)
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(
            viewModel: PokemonListViewModel(
                pokemonService: PokemonServiceFactory.newService()
            )
        )
    }
}

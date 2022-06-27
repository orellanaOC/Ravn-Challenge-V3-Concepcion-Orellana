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
                                generation: generation,
                                pokemons: viewModel.searchText.isEmpty ?
                                viewModel.pokemons:
                                    viewModel.pokemonsFiltered,
                                isShowGeneration: viewModel.isShowGeneration
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
                    ) // API error alert
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

                    if viewModel.isShowingConnectionLost,
                       viewModel.pokemons.isEmpty {
                        NetworkImageView()
                    }

                    if viewModel.isErrorToLoadData {
                        FailedToLoadDataView()
                    }
                }
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )

            Progress(isLoading: viewModel.isLoading)
        }
        .alert(isPresented: $viewModel.isShowingConnectionLost) {
            Alert(title: Text("Connectivity Issue"),
                  message: Text("There is a problem trying to connect. \nPlease check your connectivity"),
                  primaryButton:
                    .default(
                        Text("Try Again"),
                        action: { viewModel.loadData() }
                    ),
                  secondaryButton:
                    .cancel()
            )
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(
            viewModel: PokemonListViewModel(
                pokemonService: PokemonServiceFactory.newService(),
                connectivity: ConnectivityService(networkMonitor: NetworkMonitor())
            )
        )
    }
}

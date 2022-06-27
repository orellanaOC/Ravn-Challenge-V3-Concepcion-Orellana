//
//  PokemonInfoView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/22/22.
//

import Kingfisher
import SwiftUI

struct PokemonInfoView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: PokemonDetailViewModel
    @State var isSelected = true

    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                if !viewModel.pokemon.color.isEmpty {
                    Color(viewModel.pokemon.color)
                }

                VStack(alignment: .center) {
                    ZStack {
                        KFImage(
                            URL(
                                string: viewModel.spriteTypeSelected == 0 ?
                                viewModel.pokemon.sprites.frontDefault :
                                    viewModel.pokemon.sprites.frontShiny
                            )
                        )
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .frame(
                            minWidth: DrawingConstants.measure50,
                            maxWidth: DrawingConstants.measure200,
                            minHeight: DrawingConstants.measure50,
                            maxHeight: DrawingConstants.measure200,
                            alignment: .center
                        )
                        .padding(
                            .init(
                                top: -DrawingConstants.measure15,
                                leading: DrawingConstants.measure0,
                                bottom: -DrawingConstants.measure20,
                                trailing: DrawingConstants.measure0
                            )
                        )
                        .clipped()
                        .padding(.horizontal)

                        ZStack(alignment: .topLeading) {
                            if viewModel.pokemon.isLegendary {
                                Image("Legendary")
                                    .padding(
                                        .init(
                                            top: DrawingConstants.measure0,
                                            leading: DrawingConstants.measure20,
                                            bottom: DrawingConstants.measure100,
                                            trailing: DrawingConstants.measure0
                                        )
                                    )
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                            }
                        }
                    }

                    if viewModel.pokemon.id > -1 {
                        Picker(
                            "Sprite Type",
                            selection: $viewModel.spriteTypeSelected
                        ) {
                            Text("Default Sprite").tag(0)
                            Text("Shiny Sprite").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    }

                    PokemonDetailView(
                        isLoading: viewModel.isLoading,
                        pokemon: viewModel.pokemon
                    )
                }
            }
            .navigationBarTitle(Text("Pokemon Info"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.presentation.wrappedValue.dismiss()
                        }
                }
            }
            .onAppear {
                viewModel.getPokemon()
            } // API error alert
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Error"),
                      message: Text(viewModel.errorMessage ?? "Failed to Load Data"),
                      primaryButton:
                        .default(
                            Text("Try Again"),
                            action: { viewModel.getPokemon() }
                        ),
                      secondaryButton:
                        .cancel { self.presentation.wrappedValue.dismiss() }
                )
            }

            if viewModel.isShowingConnectionLost {
                NetworkImageView()
            }

            Progress(isLoading: viewModel.isLoading)
        }
    }

    private struct DrawingConstants {
        static let measure0: CGFloat = .zero
        static let measure15: CGFloat = 15
        static let measure20: CGFloat = 20
        static let measure50: CGFloat = 50
        static let measure100: CGFloat = 100
        static let measure200: CGFloat = 200
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(
            viewModel: PokemonDetailViewModel(
                pokemonID: -1,
                pokemonService: PokemonServiceFactory.newService(),
                connectivity: ConnectivityService(networkMonitor: NetworkMonitor())
            )
        )
    }
}

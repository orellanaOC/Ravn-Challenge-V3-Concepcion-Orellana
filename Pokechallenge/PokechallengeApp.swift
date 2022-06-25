//
//  PokechallengeApp.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

@main
struct PokechallengeApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonListView(
                viewModel: PokemonListViewModel(
                    pokemonService: PokemonServiceFactory.newService()
                )
            )
        }
    }
}

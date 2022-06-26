//
//  GenerationView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct GenerationView: View {
    let generation: String
    let pokemons: [PokemonSearch]
    var isShowGeneration = true

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if isShowGeneration {
                Text(generation)
                    .padding(.top)

                Divider()
            }

            ForEach(pokemons, id: \.id) { pokemon in
                if pokemon.generation == generation {
                    PokemonView(pokemon: pokemon)
                }
            }
        }
    }
}

struct GenerationView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationView(generation: "", pokemons: [])
    }
}

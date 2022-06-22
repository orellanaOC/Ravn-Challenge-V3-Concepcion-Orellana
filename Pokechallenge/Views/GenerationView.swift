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

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(generation)
                .padding(.top)

            Divider()

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
        GenerationView(generation: "Generation X", pokemons: [])
    }
}

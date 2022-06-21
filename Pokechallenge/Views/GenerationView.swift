//
//  GenerationView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct GenerationView: View {
    let generation: String
    let pokemons: [Pokemon] = [
        .init(id: 1,
              name: "Poke",
              generation: Generation.generationI.rawValue,
              sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/810.png",
              flavours: [Flavour.init(name: "Grass")]),
        .init(id: 2,
              name: "Poke2",
              generation: Generation.generationI.rawValue,
              sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/810.png",
              flavours: [.init(name: "Grass"), .init(name: "Grass")])
    ]

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
        GenerationView(generation: "Generation X")
    }
}

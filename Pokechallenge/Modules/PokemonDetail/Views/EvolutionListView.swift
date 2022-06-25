//
//  EvolutionListView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct EvolutionListView: View {
    let isLoading: Bool
    let pokemon: Pokemon

    var body: some View {
        VStack {
            Text("Evolutions")
                .font(
                    .title3
                        .weight(.regular)
                )

            List(pokemon.evolutions, id: \.id) { evolution in
                EvolutionView(pokemon: pokemon, evolution: evolution)
                    .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .onAppear {
                UITableView
                    .appearance()
                    .separatorColor = .clear
            }
        }
    }
}

struct EvolutionListView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionListView(
            isLoading: false,
            pokemon: .example
        )
    }
}

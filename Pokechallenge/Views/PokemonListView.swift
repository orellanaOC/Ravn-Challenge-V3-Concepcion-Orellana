//
//  PokemonListView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct PokemonListView: View {
    let generations = Generation.allCases

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<8) { index in
                    GenerationView(generation: generations[index].rawValue)
                }
            }
            .listStyle(.plain)
            .onAppear {
                UITableView
                    .appearance()
                    .separatorColor = .clear
            }
            .navigationTitle(
                Text("Pokemon List")
            )
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

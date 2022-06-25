//
//  PokemonImageView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import Kingfisher
import SwiftUI

struct PokemonImageView: View {
    let image: String

    var body: some View {
        ZStack {
            Circle()
                .fill(Color("PokemonCard"))
                .frame(
                    maxWidth: DrawingConstants.measure300,
                    maxHeight: DrawingConstants.measure300,
                    alignment: .center
                )

            KFImage(URL(string: image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .frame(
                    maxWidth: DrawingConstants.measure50,
                    maxHeight: DrawingConstants.measure50,
                    alignment: .center
                )
                .padding(
                    .init(
                        top: DrawingConstants.measure0,
                        leading: DrawingConstants.measure0,
                        bottom: DrawingConstants.measure0,
                        trailing: DrawingConstants.measure0
                    )
                )
                .clipped()
        }
    }

    private struct DrawingConstants {
        static let measure0: CGFloat = .zero
        static let measure50: CGFloat = 50
        static let measure300: CGFloat = 300
    }
}

struct PokemonSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(image: "")
    }
}

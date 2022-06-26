//
//  FlavourView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct FlavourView: View {
    let flavours: [Flavour]

    var body: some View {
        HStack(alignment: .center, spacing: DrawingConstants.measure10) {
            ForEach(flavours) { flavour in
                Image(flavour.name)
                    .padding(
                        .init(
                            top: -DrawingConstants.measure10,
                            leading: -DrawingConstants.measure10,
                            bottom: -DrawingConstants.measure10,
                            trailing: -DrawingConstants.measure10
                        )
                    )
            }
        }
        .padding(.trailing)
    }

    private struct DrawingConstants {
        static let measure10: CGFloat = 10
    }
}

struct FlavourView_Previews: PreviewProvider {
    static var previews: some View {
        FlavourView(flavours: [])
    }
}

//
//  FailedToLoadDataView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct FailedToLoadDataView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Failed to Load Data")
                .font(
                    .footnote
                        .weight(.light)
                )
                .foregroundColor(.red)

            Spacer()
        }
    }
}

struct FailedToLoadDataView_Previews: PreviewProvider {
    static var previews: some View {
        FailedToLoadDataView()
    }
}

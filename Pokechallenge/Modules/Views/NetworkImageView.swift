//
//  NetworkImageView.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import SwiftUI

struct NetworkImageView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("Network")
                .foregroundColor(.gray)

            Spacer()
        }
    }
}

struct NetworImageView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImageView()
    }
}

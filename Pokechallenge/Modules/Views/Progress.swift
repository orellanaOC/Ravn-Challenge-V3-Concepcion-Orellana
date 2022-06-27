//
//  Progress.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/20/22.
//

import SwiftUI

struct Progress: View {
    let isLoading: Bool
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .opacity(1)
            } else {
                EmptyView()
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Progress(isLoading: false)
    }
}

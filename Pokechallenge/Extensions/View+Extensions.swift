//
//  View+Extensions.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(
            content: self,
            modifier: CornerRadiusStyle(
                radius: radius,
                corners: corners
            )
        )
    }
}

//
//  CornerRadiusStyle.swift
//  Pokechallenge
//
//  Created by Concepcion Orellana on 6/25/22.
//

import Foundation
import SwiftUI

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {
        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(
                    width: radius,
                    height: radius
                )
            )

            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(
                CornerRadiusShape(
                    radius: radius,
                    corners: corners
                )
            )
    }
}

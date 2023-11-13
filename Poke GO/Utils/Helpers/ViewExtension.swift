//
//  ViewExtension.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI

public extension View {
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

  struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

       public func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

 func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

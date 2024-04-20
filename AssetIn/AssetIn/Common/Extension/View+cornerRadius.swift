//
//  View+cornerRadius.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import SwiftUI

public struct RoundedShape: Shape {
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedShape(radius: radius, corners: corners))
    }
}


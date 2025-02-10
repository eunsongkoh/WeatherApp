//
//  Extensions.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
//

import Foundation
import SwiftUI

// allows you to add new functionality to an existing class, struct, enum, or protocol type.
//No subclassing needed: You don’t need to subclass a type to extend its functionality. Instead, you can directly add new capabilities.
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

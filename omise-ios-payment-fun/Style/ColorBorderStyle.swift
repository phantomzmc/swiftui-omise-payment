//
//  ColorBorderStyle.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI

struct ColorBorderStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .light ? Color.gray : Color.gray, lineWidth: 0.5)
            )
    }
}

extension View {
    func addColorBorderStyle() -> some View {
        modifier(ColorBorderStyle())
    }
}

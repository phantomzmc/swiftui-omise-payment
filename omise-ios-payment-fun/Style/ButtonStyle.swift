//
//  ButtonStyle.swift
//  omise-ios-payment-fun
//
//  Created by Thannathorn Yuwasin on 13/7/2567 BE.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
            content
            .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(colorScheme == .light ? Color.blue : Color.white)
                                )
        }
}

extension View {
    func addColorButtonStyle() -> some View {
        modifier(ButtonStyle())
    }
}

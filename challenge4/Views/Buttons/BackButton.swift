//
//  BackButton.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

/// A button style that adds a “bouncy” animation when the button is pressed.
struct BounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // Scale down when pressed and animate with a spring effect
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(
                .spring(response: 0.3, dampingFraction: 0.5),
                value: configuration.isPressed
            )
    }
}

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .padding(24)
                .background(
                    Circle()
                        .fill(Color("EmotionBarColorDropShadow"))
                )
        }
        // Apply the custom bouncy button style
        .buttonStyle(BounceButtonStyle())
    }
}

#Preview {
    BackButton()
}

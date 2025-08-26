//
//  BackButton.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

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
        .offset(y: 20)
    }
}

#Preview {
    BackButton()
}

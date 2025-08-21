//
//  Cards.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

struct Cards: View {
    /// Represents the current card state: Feeling, Why, Need, or Games.
    enum CardState {
        case feeling, why, need, games
    }

    /// The state controlling which card content to show.
    var state: CardState

    var body: some View {
        VStack(spacing: 0) {
            // Title section
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            // Thin separator with default divider colour at 10 % opacity
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .frame(height: 1)

            // Content section
            content
                .padding()
        }
        .background(Color("EmotionBarColor"))
        .cornerRadius(20)
        .padding(.horizontal, 5)
    }

    /// Returns the appropriate title for each state.
    private var title: String {
        switch state {
        case .feeling:
            return "How I'm Feeling Today"
        case .why:
            return "Why I Feel That Way"
        case .need:
            return "What I Need"
        case .games:
            return "Can you tell me a story about your childhood?"
        }
    }

    /// Returns the appropriate content view for each state.
    @ViewBuilder
    private var content: some View {
        switch state {
        case .feeling:
            Image("HappyFace")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
        case .why, .games:
            // Both Why and Games use a RecordButton as their content
            BackButton()
        case .need:
            Text("Rest")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color("EmotionBarColorDropShadow"))
                .clipShape(Capsule())
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        Cards(state: .feeling)
        Cards(state: .why)
        Cards(state: .need)
        Cards(state: .games) // preview for the new Games state
    }
    .padding()
    .background(Color(.systemBackground))
}

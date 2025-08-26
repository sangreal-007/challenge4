//
//  GrowCloserContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct GrowCloserContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("OnboardingBunnies")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            VStack(spacing: 8) {
                Text("Grow closer together")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                
                Text("Build stronger bonds through meaningful conversations")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
            }
        }
        .padding(.bottom, 100)
    }
}

#Preview {
    GrowCloserContent()
        .background(.black)
}

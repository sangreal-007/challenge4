//
//  OnboardingCards.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

enum OnboardingState: String, CaseIterable {
    case sharefeeling = "sharefeeling"
    case growcloser = "growcloser"
    case bedtimeritual = "bedtimeritual"
    case allowmic = "allowmic"
}

struct OnboardingCards: View {
    @State private var currentState: OnboardingState = .sharefeeling
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            // Card background
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .strokeBorder(Color.cardBorder, lineWidth: 8)
                )
                .shadow(color: .black.opacity(0.35), radius: 18, y: 8)
                .frame(width: 344, height: 512)
            
            // Content based on current state
            VStack(spacing: 0) {
                // Main content area
                ZStack {
                    switch currentState {
                    case .sharefeeling:
                        ShareFeelingContent()
                    case .growcloser:
                        GrowCloserContent()
                    case .bedtimeritual:
                        BedtimeRitualContent()
                    case .allowmic:
                        AllowMicContent()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
            }
            .padding(.top, 20)
            
            // Bottom button area
            VStack {
                Spacer()
                
                if currentState == .allowmic {
                    PermissionButtons(onAllow: {
                        print("Microphone permission granted")
                        // Handle completion or navigation
                    }).padding(.bottom, -25)
                } else {
                    NextButton(action: {
                        handleNextButtonTap()
                    })
                }
            }
            .padding(.bottom, 185)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func handleNextButtonTap() {
        print("NextButton tapped - Current state: \(currentState.rawValue)")
        
        switch currentState {
        case .sharefeeling:
            currentState = .growcloser
        case .growcloser:
            currentState = .bedtimeritual
        case .bedtimeritual:
            currentState = .allowmic
        case .allowmic:
            // This case shouldn't be reached since allowmic shows PermissionButtons
            print("Completed onboarding")
        }
        
        print("New state: \(currentState.rawValue)")
    }
}

#Preview {
    OnboardingCards()
}

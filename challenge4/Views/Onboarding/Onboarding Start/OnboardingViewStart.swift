import SwiftUI

struct OnboardingViewStart: View {
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToCarousel = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // BACKGROUND
                Color.background
                    .ignoresSafeArea()
                
                // STARS
                    .overlay(alignment: .topLeading) {
                        OnboardingStarsView()
                    }

                
                // TITLE
                    .overlay(alignment: .topLeading) {
                        OnboardingTitleView()
                    }
                
                // CONTENT (bunnies at bottom)
                OnboardingBunniesView()
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    navigateToCarousel = true
                }
            }
            .navigationDestination(isPresented: $navigateToCarousel) {
                OnboardingCards()
            }
        }
    }
}

#Preview {
    OnboardingViewStart()
}


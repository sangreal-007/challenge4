import SwiftUI

// MARK: - Carousel
struct OnboardingCarouselView: View {
    @State private var index = 0
    
    // EDIT HERE: swap assets & text per page with custom positioning
    let pages: [OnboardingPage] = [
        // Page 1: 3-face cluster + single main image
        .init(
            main: .single("onb_feelings", width: 250, height: 200, offsetY: -50),
            faces: [
                .init("OnboardingSadFace", width: 82, offsetX: -92, offsetY: -38),
                .init("OnboardingAngryFace", width: 100, offsetX: 0, offsetY: -10),
                .init("OnboardingHappyFace", width: 92, offsetX: 87, offsetY: -48)
            ],
            overlay: nil,
            title: "Share your feelings",
            subtitle: "Reflect on your day with your child using NVC framework"
        ),
        // Page 2: DUO main images ONLY (no face cluster)
        .init(
            main: .duo("RabbitParent", "RabbitChild",
                       leftWidth: 180, leftHeight: 180, leftOffsetX: -55, leftOffsetY: 140,
                       rightWidth: 150, rightHeight: 150, rightOffsetX: 55, rightOffsetY: 160),
            faces: nil,
            overlay: .dice,
            title: "Grow closer every day",
            subtitle: "With different topics each day, have a deep heartwarming conversation"
        ),
        // Page 3: Single main image ONLY (no face cluster)
        .init(
            main: .single("Calendar", height: 250, offsetX: 10, offsetY: 90),
            faces: nil,
            overlay: nil,
            title: "Build a bedtime ritual",
            subtitle: "Collect memory stars together"
        ),
        // Page 4: Microphone permission screen
        .init(
            main: .single("RabbitAudio", width: 300, offsetX: 10, offsetY: 110),
            faces: nil,
            overlay: nil,
            title: "Record precious moments",
            subtitle: "Let the app keep your memories safe"
        )
    ]
    
    var onFinish: (() -> Void)? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(hexValue: 0x0F0D39).ignoresSafeArea()
                
                TabView(selection: $index) {
                    ForEach(pages.indices, id: \.self) { i in
                        OnboardingCard(page: pages[i], isLast: i == pages.count - 1, onNext: advance)
                            .frame(width: cardWidth(geo), height: cardHeight(geo))
                            .tag(i)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Dots (purple)
                VStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { i in
                            Circle()
                                .fill(i == index ? Color.accentPurple : Color.accentPurple.opacity(0.35))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
    
    private func advance() {
        if index < pages.count - 1 {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) { index += 1 }
        } else {
            onFinish?()
        }
    }
    
    // Sizing
    private func cardWidth(_ geo: GeometryProxy) -> CGFloat {
        let target: CGFloat = 380
        let margin: CGFloat = 20
        return min(geo.size.width - margin * 2, target)
    }
    private func cardHeight(_ geo: GeometryProxy) -> CGFloat {
        cardWidth(geo) * (571.0 / 337.0)
    }
}



// MARK: - Preview
#Preview {
    OnboardingCarouselView()
}

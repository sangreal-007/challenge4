import SwiftUI

struct OnboardingBunniesView: View {
    @State private var slideOffset: CGFloat = 300
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("bunnies_bed")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width + 2)
                    .ignoresSafeArea(edges: .bottom)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .bottom)
            }
            .allowsHitTesting(false)
        }
        .ignoresSafeArea(edges: .bottom)
        .offset(y: slideOffset)
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                slideOffset = 0
            }
        }
    }
}

#Preview {
    OnboardingBunniesView()
        .background(Color.black)
}

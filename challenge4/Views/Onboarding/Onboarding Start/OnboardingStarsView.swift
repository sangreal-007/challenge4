import SwiftUI

struct OnboardingStarsView: View {
    @State private var slideOffset: CGFloat = -300
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .top, spacing: 8) {
                Image("stars")
                    .resizable().scaledToFit()
                    .frame(height: 210)
                
                Image("stars2")
                    .resizable().scaledToFit()
                    .frame(height: 140)
                    .offset(x: -60, y: -5)
            }
            .padding(.leading, 24)
            .padding(.top, -geo.safeAreaInsets.top)
            .frame(width: geo.size.width, height: geo.size.height,
                   alignment: .topLeading)
            .offset(y: slideOffset)
            .onAppear {
                withAnimation(.easeOut(duration: 1.2)) {
                    slideOffset = 0
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    OnboardingStarsView()
        .background(Color.black)
}

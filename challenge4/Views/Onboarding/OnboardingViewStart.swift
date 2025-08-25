import SwiftUI

struct OnboardingViewStart: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // BACKGROUND
                Color.background
                    .ignoresSafeArea()
                
                // STARS
                    .overlay(alignment: .topLeading) {
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
                        }
                        .ignoresSafeArea(edges: .top)
                    }

                
                // TITLE
                    .overlay(alignment: .topLeading) {
                        let accent = Color(red: 0.46, green: 0.45, blue: 1)
                        (Text("When it’s ").foregroundColor(.white)
                         + Text("bed time").foregroundColor(accent)
                         + Text(",\nyou and your kid have\na warm quality time…").foregroundColor(.white))
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .frame(width: 277, alignment: .leading)
                        .padding(.leading, 32)  // Left = 32
                        .padding(.top, 195)     // Top = 245
                        .fixedSize(horizontal: false, vertical: true)
                    }
                
                // CONTENT (bunnies at bottom)
                VStack {
                    // BUNNIES
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
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    OnboardingViewStart()
}


import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Model
struct OnboardingPage: Identifiable, Equatable {
    let id = UUID()
    let main: MainIllustration            // single or duo - LARGE main illustration
    let faces: [FacePosition]?            // optional face cluster - SMALL images above text
    let overlay: Overlay?                 // optional per-page overlay (e.g., dice)
    let title: String
    let subtitle: String
    
    enum MainIllustration: Equatable {
        case single(String, width: CGFloat? = nil, height: CGFloat? = nil, offsetX: CGFloat = 0, offsetY: CGFloat = 0)
        case duo(String, String, leftWidth: CGFloat? = nil, leftHeight: CGFloat? = nil, leftOffsetX: CGFloat = 0, leftOffsetY: CGFloat = 0,
                 rightWidth: CGFloat? = nil, rightHeight: CGFloat? = nil, rightOffsetX: CGFloat = 0, rightOffsetY: CGFloat = 0)
    }
    
    struct FacePosition: Equatable {
        let imageName: String
        let width: CGFloat?
        let height: CGFloat?
        let offsetX: CGFloat
        let offsetY: CGFloat
        
        init(_ imageName: String, width: CGFloat? = nil, height: CGFloat? = nil, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
            self.imageName = imageName
            self.width = width
            self.height = height
            self.offsetX = offsetX
            self.offsetY = offsetY
        }
    }
    
    enum Overlay: Equatable { case dice }
    
    // Special button configuration for permission screens
    var hasPermissionButtons: Bool {
        title == "Record precious moments"
    }
}

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
                Color(hex: 0x0F0D39).ignoresSafeArea()
                
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

// MARK: - Card
struct OnboardingCard: View {
    let page: OnboardingPage
    let isLast: Bool
    let onNext: () -> Void
    
    var body: some View {
        ZStack {
            // Card frame
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color(hex: 0x1E1C70))
                .overlay(
                    RoundedRectangle(cornerRadius: 36, style: .continuous)
                        .strokeBorder(Color(hex: 0x181858), lineWidth: 8)
                )
                .shadow(color: .black.opacity(0.35), radius: 18, y: 8)
            
            // Overlay (e.g., dice)
            if page.overlay == .dice {
                DiceCorner()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top, 30)
                    .padding(.leading, 15)
            }
            
            // Main content with consistent layout
            VStack(spacing: 0) {
                
                // Main illustration area with fixed height
                ZStack {
                    switch page.main {
                    case .single(let name, let width, let height, let offsetX, let offsetY):
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width, height: height)
                            .offset(x: offsetX, y: offsetY)
                        
                    case .duo(let leftName, let rightName,
                              let leftWidth, let leftHeight, let leftOffsetX, let leftOffsetY,
                              let rightWidth, let rightHeight, let rightOffsetX, let rightOffsetY):
                        
                        Image(leftName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: leftWidth, height: leftHeight)
                            .offset(x: leftOffsetX, y: leftOffsetY)
                        
                        Image(rightName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: rightWidth, height: rightHeight)
                            .offset(x: rightOffsetX, y: rightOffsetY)
                    }
                }
                .frame(height: 220)
                .padding(.top, 10)
                
                // Face cluster area with fixed height
                ZStack {
                    if let faces = page.faces, !faces.isEmpty {
                        ForEach(faces.indices, id: \.self) { index in
                            let face = faces[index]
                            Image(face.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: face.width, height: face.height)
                                .offset(x: face.offsetX, y: face.offsetY)
                        }
                    } else {
                        Color.clear
                    }
                }
                .frame(height: 120)
                .padding(.top, 10)
                
                // Text area with TIGHTER spacing (changed from 10 to 6)
                VStack(spacing: 6) {
                    Text(page.title)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(page.subtitle)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: 320)
                .padding(.top, 16) // Reduced from 20 to 16
                
                Spacer() // This Spacer will now push the content to the top
            }
            .padding(0)
        }
        // Permission buttons for microphone screen
        .overlay(alignment: .bottom) {
            if page.hasPermissionButtons {
                PermissionButtons(onAllow: onNext)
                    .padding(.bottom, 56)
                    .zIndex(10)
            } else {
                NextButton(isLast: isLast, action: onNext)
                    .padding(.bottom, 56)
                    .zIndex(10)
            }
        }
    }
}

// MARK: - Dice overlay
private struct DiceCorner: View {
    var body: some View {
#if canImport(UIKit)
        if UIImage(named: "DiceImage") != nil {
            Image("DiceImage")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 148)
                .allowsHitTesting(false)
        } else {
            vectorDice
        }
#else
        vectorDice
#endif
    }
    
    private var vectorDice: some View {
        let base = Color(hex: 0x7672FF).opacity(0.10)
        let pip  = Color(hex: 0x7672FF).opacity(0.22)
        
        return ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(base)
                .frame(width: 160, height: 148)
            
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(base)
                .frame(width: 125, height: 115)
                .offset(x: 23, y: 21)
            
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(base)
                    .frame(width: 93, height: 93)
                
                let d: CGFloat = 12
                Circle().fill(pip).frame(width: d, height: d).offset(x: -21, y: -21)
                Circle().fill(pip).frame(width: d, height: d).offset(x:  21, y: -21)
                Circle().fill(pip).frame(width: d, height: d)
                Circle().fill(pip).frame(width: d, height: d).offset(x: -21, y:  21)
                Circle().fill(pip).frame(width: d, height: d).offset(x:  21, y:  21)
            }
            .offset(x: 51, y: 44)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Permission Buttons
private struct PermissionButtons: View {
    let onAllow: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Allow Microphone button
            Button(action: onAllow) {
                HStack(spacing: 12) {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text("Allow Microphone")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                .frame(width: 272, height: 64)
                .background(Color(hex: 0x3E3BC8))
                .cornerRadius(57)
                .shadow(color: Color(hex: 0x2B28B2), radius: 0, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 57)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .shadow(color: Color.white.opacity(0.25), radius: 0, x: 1, y: 5)
                        .blendMode(.overlay)
                )
            }
            .buttonStyle(ScaleButtonStyle())
            
            // Later in Settings button
            Button(action: onAllow) { // Same action for now
                Text("Later in Settings")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(Color(hex: 0x7672FF))
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}

// MARK: - Next Button
private struct NextButton: View {
    let isLast: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(hex: 0x3E3BC8))
                    .frame(width: 69, height: 69)
                    .shadow(color: Color(hex: 0x2B28B2), radius: 0, x: 0, y: 8)
                
                Image(systemName: isLast ? "checkmark" : "chevron.right")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Colors / helpers
private extension Color {
    static let accentPurple  = Color(red: 0.46, green: 0.45, blue: 1.00)
    static let accentPurple2 = Color(red: 0.57, green: 0.47, blue: 1.00)
    
    init(hex: UInt, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

// MARK: - Preview
#Preview {
    OnboardingCarouselView()
}

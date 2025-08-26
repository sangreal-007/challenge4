

import SwiftUI

private struct Star: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
}

struct StarBackground: View {
    var starImageName: String = "StarHome"
    var count: Int = 30
    var minSize: CGFloat = 12
    var maxSize: CGFloat = 20
    
    @State private var stars: [Star] = []
    
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                // Resolve  asset once, then reuse it in the loop (faster).
                let resolved = context.resolve(Image(starImageName))
                
                for s in stars {
                    let rect = CGRect(x: s.x, y: s.y, width: s.size, height: s.size)
                    context.draw(resolved, in: rect)   // draw your star image
                }
            }
            .onAppear { stars = makeStars(in: geo.size) }
            .onChange(of: geo.size) { newSize in
                stars = makeStars(in: newSize)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false) // never block taps on foreground UI
    }
    
//        private func makeStars(in size: CGSize) -> [Star] {
//            guard size.width > 0, size.height > 0 else { return [] }
//            return (0..<count).map { _ in
//                Star(
//                    x: .random(in: 0...size.width),
//                    y: .random(in: 0...size.height),
//                    size: .random(in: minSize...maxSize)
//                )
//            }
//        }
//    }
    private func makeStars(in size: CGSize) -> [Star] {
        guard size.width > 0, size.height > 0, count > 0 else { return [] }
        
        let cx = size.width  / 2
        let cy = size.height / 2
        let circleRadiusGlobal = min(size.width, size.height) / 2
        
        return (0..<count).map { _ in
            // Pick size first so each star stays fully inside the circle.
            let s = CGFloat.random(in: minSize...maxSize)
            let rMax = circleRadiusGlobal - s / 2
            
            // Uniform point in a disk: r = R * sqrt(U), θ = 2πV
            let u = CGFloat.random(in: 0...1)
            let v = CGFloat.random(in: 0...1)
            let r = rMax * sqrt(u)
            let theta = 2 * .pi * v
            
            let x = cx + r * cos(theta)
            let y = cy + r * sin(theta)
            return Star(x: x, y: y, size: s)
        }
    }
}


struct RotatingStars: View {
    @State private var angle = Angle.zero
    
    var body: some View {
        StarBackground(starImageName: "StarHome", count: 5, minSize: 12, maxSize: 20)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            .rotationEffect(angle) // rotates content, not the frame
            .onAppear {
                // 360° in 20s → 90° every 5s
                withAnimation(.linear(duration: 16).repeatForever(autoreverses: false)) {
                    angle = .degrees(360)
                }
            }
        
        
    }
}






#Preview {
    RotatingStars()
}

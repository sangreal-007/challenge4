//import SwiftUI
//
//struct RisingMemoryStar: View {
//    var imageName = "StarHome"
//
//    var startY: CGFloat = 0.62
//
//    var endY: CGFloat = 0.12
//    var travelDuration: Double = 1.2
//    var startScale: CGFloat = 0.4
//    var endScale: CGFloat = 1.0
//    var shinePulses: Int = 2
//
//    @State private var pos: CGPoint = .zero
//    @State private var scale: CGFloat = 0.4
//    @State private var shining = false
//
//    var body: some View {
//        GeometryReader { geo in
//            let cx = geo.size.width / 2
//            let start = CGPoint(x: cx, y: geo.size.height * startY)
//            let end   = CGPoint(x: cx, y: geo.size.height * endY)
//
//            Image(imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 56, height: 56)
//                .position(pos)
//                .scaleEffect(scale)
//                // subtle base glow
//                .shadow(color: .white.opacity(0.25), radius: 8, x: 0, y: 0)
//                // “shine” burst when it arrives
//                .overlay(
//                    Circle()
//                        .strokeBorder(.white.opacity(shining ? 0.95 : 0), lineWidth: shining ? 8 : 0)
//                        .blur(radius: shining ? 10 : 0)
//                        .blendMode(.screen) // makes the highlight pop on dark bg
//                )
//                .onAppear {
//                    // set at start
//                    pos = start
//                    scale = startScale
//
//                    // travel upward while growing
//                    withAnimation(.easeInOut(duration: travelDuration)) {
//                        pos = end
//                        scale = endScale
//                    }
//
//                    // start the shine once we arrive
//                    DispatchQueue.main.asyncAfter(deadline: .now() + travelDuration) {
//                        withAnimation(.easeInOut(duration: 0.6).repeatCount(shinePulses * 2, autoreverses: true)) {
//                            shining = true
//                        }
//                        // optional: settle the shine back down
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6 * Double(shinePulses * 2)) {
//                            shining = false
//                        }
//                    }
//                }
//        }.background(.black)
//        .allowsHitTesting(false) // won’t block your buttons
//    }
//}
//
//struct RisingStar: View {
//    var body: some View {
//        ZStack {
//            // … background …
//
//            // rabbits here
//
//            RisingMemoryStar(imageName: "StarHome",
//                             startY: 0.62,  // tweak to match your rabbits’ vertical line
//                             endY: 0.12)    // how close to the top you want to stop
//            .zIndex(2) // make sure it renders above the rabbits
//        }
//    }
//}
//
//#Preview{
//    RisingStar()
//}


import SwiftUI

struct RisingStar: View {
        // Values we animate with keyframes
        struct Values {
            var position = CGPoint.zero
            var scale: CGFloat = 2
            var glow: CGFloat = 0.0   // your existing one-shot "arrival" glow track
        }

        @State private var go = false

        var body: some View {
            GeometryReader { geo in
                let cx = geo.size.width / 2
                let start = CGPoint(x: cx, y: geo.size.height * 0.82)
                let end   = CGPoint(x: cx, y: geo.size.height * 0.12)

                KeyframeAnimator(initialValue: Values(), trigger: go) { v in
                    // Base star driven by your keyframes…
                    Image("StarHome")
                        .resizable().scaledToFit()
                        .frame(width: 56, height: 56)
                        .position(v.position)                     // center placed here
                        .scaleEffect(1.4 * v.scale, anchor: .center)

                        // …then apply an endless glow pulse with PhaseAnimator.
                        // It cycles 0.8 <-> 1.0 forever with the given animation.
                        .phaseAnimator([0.8, 1.0]) { content, phase in
                            // Combine your one-shot glow (v.glow) with the looping pulse.
                            // v.glow rises then settles; pulse keeps it "breathing".
                            let pulse = 0.4 + 0.6 * phase          // tune min/max brightness
                            let g = max(v.glow, pulse)             // never dimmer than the pulse

                            content
                                // stacked shadows => bright bloom-style glow
                                .shadow(color: .white.opacity(1 * g), radius: 18 + 18 * g)
                                .shadow(color: .white.opacity(1 * g), radius: 18 + 18 * g)
                                .shadow(color: .white.opacity(0.8 * g), radius: 36 + 24 * g)
                        } animation: {_ in
                            .easeInOut(duration: 1.0)              // pulse speed/curve
                        }
                } keyframes: { _ in
                    // 1) Move up
                    KeyframeTrack(\.position) {
                        CubicKeyframe(start, duration: 0.0)
                        LinearKeyframe(end,  duration: 1.2)
                    }
                    // 2) Grow while moving
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.4, duration: 0.0)
                        LinearKeyframe(1.0, duration: 1.2)
                    }
                    // 3) One-shot glow curve (you can keep your "settle to 0.2"
                    //    or change the last keyframe to 1.0 if you want it always bright)
                    KeyframeTrack(\.glow) {
                        CubicKeyframe(0.0, duration: 1.2)    // while traveling
                        SpringKeyframe(1.0, duration: 0.5)   // burst
                        LinearKeyframe(0.2, duration: 0.5)   // settle baseline
                    }
                }
                .onAppear { go.toggle() }                     // triggers the keyframes
            }.background(.black)
            .frame(maxWidth: .infinity, maxHeight: 650)
            .allowsHitTesting(false)
        }
    }

#Preview{
    RisingStar()
}

//
//  RisingStar2.swift
//  challenge4
//
//  Created by Ardelia on 25/08/25.
//
import SwiftUI

struct RisingStar1: View {
    // Values we animate with keyframes
    struct Values {
        var position = CGPoint.zero
        var scale: CGFloat = 2
        var glow: CGFloat = 0.0
    }
    
    @State private var go = false
    
    var body: some View {
        GeometryReader { geo in
            let cx = geo.size.width / 2
            // tweak these to start between your rabbits and stop near the top
            let start = CGPoint(x: cx, y: geo.size.height * 0.82)
            let end   = CGPoint(x: cx, y: geo.size.height * 0.18)
            
            KeyframeAnimator(initialValue: Values(), trigger: go) { v in
                ZStack {
                    // Your star image
                    Image("StarHome")
                        .resizable().scaledToFit()
                        .frame(width: 56, height: 56)
                        .position(v.position)
                        .scaleEffect( 1.4 * v.scale, anchor: .center)
                    // soft glow that peaks on arrival
                        .shadow(color: .white.opacity(1 * v.glow), radius: 18 + 18 * v.glow)
                        .shadow(color: .white.opacity(1 * v.glow), radius: 18 + 18 * v.glow)
                        .shadow(color: .white.opacity(0.8 * v.glow), radius: 36 + 24 * v.glow)
                }
            } keyframes: { _ in
                // 1) Move up in 1.2s
                KeyframeTrack(\.position) {
                    CubicKeyframe(start, duration: 0.0)
                    LinearKeyframe(end,  duration: 1.2)
                }
                // 2) Grow while moving
                KeyframeTrack(\.scale) {
                    CubicKeyframe(0.4, duration: 0.0)
                    LinearKeyframe(1.0, duration: 1.2)
                }
                // 3) Glow rises right after arrival, then settles
                KeyframeTrack(\.glow) {
                    CubicKeyframe(0.0, duration: 1.2)           // hold while traveling
                    SpringKeyframe(1.0, duration: 1.5)          // burst
                    LinearKeyframe(0.2, duration: 2.0)          // settle
                }
            }
            .onAppear { go.toggle()

            }
        }/*.background(.black)*/
            .frame(maxWidth: .infinity, maxHeight: 650)
            .allowsHitTesting(false) // decorative only
    }
}


//struct RisingStar1: View {
//    var body: some View {
//        ZStack {
//            // … background …
//
//            // rabbits here
//
//            RisingMemoryStar1(imageName: "StarHome",
//                             startY: 0.62,  // tweak to match your rabbits’ vertical line
//                             endY: 0.12)    // how close to the top you want to stop
//            .zIndex(2) // make sure it renders above the rabbits
//        }
//    }
//}

#Preview{
    RisingStar1()
}

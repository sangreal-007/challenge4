//
//  FallingStar.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct FallingStar: View {
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
            // Reverse of RisingStar1: start from top and fall to bottom
            let start = CGPoint(x: cx, y: geo.size.height * 0.18)
            let end   = CGPoint(x: cx, y: geo.size.height * 0.82)
            
            KeyframeAnimator(initialValue: Values(), trigger: go) { v in
                ZStack {
                    // Your star image
                    Image("StarHome")
                        .resizable().scaledToFit()
                        .frame(width: 56, height: 56)
                        .position(v.position)
                        .scaleEffect( 2 * v.scale, anchor: .center)
                    // soft glow that peaks at start, then fades
                        .shadow(color: .white.opacity(1 * v.glow), radius: 18 + 18 * v.glow)
                        .shadow(color: .white.opacity(1 * v.glow), radius: 18 + 18 * v.glow)
                        .shadow(color: .white.opacity(0.8 * v.glow), radius: 36 + 24 * v.glow)
                }
            } keyframes: { _ in
                // 1) Move down in 1.2s (reverse of up movement)
                KeyframeTrack(\.position) {
                    CubicKeyframe(start, duration: 1.4)
                    LinearKeyframe(end,  duration: 1.2)
                }
                // 2) Shrink while moving (reverse of grow)
                KeyframeTrack(\.scale) {
                    CubicKeyframe(1.0, duration: 1.0)
                    LinearKeyframe(0.4, duration: 1.0)
                }
                // 3) Glow starts high, then fades (reverse of rising glow)
                KeyframeTrack(\.glow) {
                    SpringKeyframe(1.0, duration: 1.0)          // start with burst
                    LinearKeyframe(0.2, duration: 1.5)          // fade quickly
                    CubicKeyframe(0.0, duration: 0.1)           // fade out completely
                }
            }
            .onAppear { go.toggle()

            }
        }/*.background(.black)*/
            .frame(maxWidth: .infinity, maxHeight: 650)
            .allowsHitTesting(false) // decorative only
    }
}

#Preview {
    FallingStar()
}

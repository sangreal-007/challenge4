//
//  AnimationExampleView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI
import Lottie

struct AnimationExampleView: View {
    @State private var ellipseScale: CGFloat = 10.0 // Start very large
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ParentsTurnCard()
                    .offset(x: -70, y: -150)
                
                // Background content (always visible)
                LottieView(name: "rabbit talk mom", // the name is the name of the .json file
                           loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                .frame(width: 283, height: 345)
                .offset(x: -140, y: -100)
                .scaleEffect(0.17)
                
                // Black tint with animated ellipse cutout
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .mask {
                        // Create inverse mask - everything except the ellipse area
                        Rectangle()
                            .overlay {
                                Ellipse()
                                    .frame(width: 240 * ellipseScale, height: 300 * ellipseScale)
                                    .offset(x: -70, y: -50)
                                    .blendMode(.destinationOut)
                            }
                    }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0)) {
                    ellipseScale = 1.0 // Shrink to normal size
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 2.0)) {
                    ellipseScale = ellipseScale == 1.0 ? 10.0 : 1.0
                }
            }
        }
    }
}

#Preview {
    AnimationExampleView()
}

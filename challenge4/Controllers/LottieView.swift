//
//  LottieView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 20/08/25.
//
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .loop
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var speed: CGFloat = 1.0

    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView()
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        animationView.backgroundBehavior = .pauseAndRestore

        // Try by resource name first (no .json), fall back to URL if needed (handles spaces in filename)
        if let animation = LottieAnimation.named(name) {
            animationView.animation = animation
            animationView.play()
        } else if let url = Bundle.main.url(forResource: name, withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let animation = try? LottieAnimation.from(data: data) {
            animationView.animation = animation
            animationView.play()
        }

        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        if !uiView.isAnimationPlaying {
            uiView.play()
        }
    }
}

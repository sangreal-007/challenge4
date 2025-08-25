//
//  RabbitsTalkingView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 25/08/25.
//

import SwiftUI
import Lottie

struct RabbitsTalkingView: View {
    var body: some View {
        ZStack{
            Image("MoonwithRock")
                .resizable()
               .scaledToFit()
               .scaleEffect(1.7)
                .offset(x: 0, y: 280)
                .allowsHitTesting(false)
            
            LottieView(name: "rabbit talk mom",
                       loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                    .frame(width: 283, height: 345)
                    .offset(x: -140, y: -100)
                    .scaleEffect(0.17)
            
            LottieView(name: "rabbit talk child",
                       loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                    .frame(width: 283, height: 345)
                    .offset(x: 60, y: -100)
                    .scaleEffect(0.14)
        }
    }
}

#Preview {
    RabbitsTalkingView()
}

//
//  RabbitStarView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct RabbitStarView: View {
    var body: some View {
        ZStack{
            Image("MoonwithRock")
                .resizable()
               .scaledToFit()
               .scaleEffect(1.7)
                .offset(x: 0, y: 380)
                .allowsHitTesting(false)
            
            LottieView(name: "rabbit mom star",
                       loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                    .frame(width: 283, height: 345)
                    .scaleEffect(0.19)
                    .offset(x: -80, y: 85)
                    
            
            LottieView(name: "rabbit child star",
                       loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                    .frame(width: 283, height: 345)
                    .scaleEffect(x: -0.14, y: 0.14)
                    .offset(x: 80, y: 94)
                    
            RisingStar1()
                            .allowsHitTesting(false)
        }
    }
}

#Preview {
    RabbitStarView()
}

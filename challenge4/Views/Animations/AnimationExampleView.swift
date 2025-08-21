//
//  AnimationExampleView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI
import Lottie

struct AnimationExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        //This is how you put in the animation
        LottieView(name: "rabbit talk child", // the name is the name of the .json file
                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                .frame(width: 283, height: 345)
                .offset(x: -300, y: 50)
                .scaleEffect(0.15)
    }
}

#Preview {
    AnimationExampleView()
}

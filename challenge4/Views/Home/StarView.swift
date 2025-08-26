//
//  StarView.swift
//  challenge4
//
//  Created by Ardelia on 22/08/25.
//

//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie



struct StarView: View {
    var body: some View {
        ZStack {
            
            RotatingStars()
            Image("FullMoon")
                .resizable()
                .scaledToFit()
                .frame(width: 79, height: 79)
                .zIndex(1)
                .offset(x: 80, y:-90)
        }
    }
    
}





#Preview {
    StarView()
}

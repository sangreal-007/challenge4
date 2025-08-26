//
//  ShareFeelingContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct ShareFeelingContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("OnboardingFaces")
                .scaleEffect(0.25)
            
            VStack(spacing: 8) {
                Text("Share your feelings")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                    .padding(.top, -180)
                
                Text("Reflect on your day with your child using NVC framework")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
                    .padding(.top, -150)
            }
        }.padding(.bottom, 100)
    }
}

#Preview {
    ShareFeelingContent()
        .background(Color.black)
}

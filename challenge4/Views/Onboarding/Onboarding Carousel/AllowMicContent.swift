//
//  AllowMicContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct AllowMicContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("RabbitAudio")
                .font(.system(size: 120))
                .foregroundColor(.white.opacity(0.8))
            
            VStack(spacing: 8) {
                Text("Allow microphone access")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                
                Text("Record your thoughts and feelings to track your journey")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
            }
        }.padding(.bottom, 125)
    }
}

#Preview {
    AllowMicContent()
        .background(Color.black)
}

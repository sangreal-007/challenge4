//
//  BedtimeRitualContent.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct BedtimeRitualContent: View {
    var body: some View {
        VStack(spacing: 20) {
            // You can replace this with appropriate bedtime image
            Image("Calendar")
                .font(.system(size: 120))
                .foregroundColor(.white.opacity(0.8))
            
            VStack(spacing: 8) {
                Text("Create bedtime rituals")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                
                Text("End each day with connection and understanding")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
            }
        }.padding(.bottom, 100)
    }
}

#Preview {
    BedtimeRitualContent()
        .background(Color.black)
}

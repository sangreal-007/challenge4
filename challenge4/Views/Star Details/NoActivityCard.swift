//
//  NoActivityCard.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

/// A shape that rounds only the specified corners of a rectangle.
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct NoActivityCard: View {
    var body: some View {
        ZStack{
                // Inner filled card
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.emotionBar)
                    .frame(width: 300, height: 500)

                Image("Moon")
                    .frame(width: 5, height: 5)
                    .scaleEffect(0.19)
                    .padding(.top, 320)
            
            // Outer hollow card — only the border is drawn
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.emotionBarColorDropShadow, lineWidth: 10)
                    .frame(width: 310, height: 510)

            
            VStack{
                Text("No Activity Today")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("It's okay, let's do it tomorrow")
                    .font(.subheadline)
                    .foregroundColor(.white)
                            
            }
        }
    }
}

#Preview {
    NoActivityCard()
}

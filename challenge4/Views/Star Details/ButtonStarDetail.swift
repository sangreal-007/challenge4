//
//  ButtonStarDetail.swift
//  challenge4
//
//  Created by Levana on 25/08/25.
//

import SwiftUI

struct ButtonStarDetail: View {
    var body: some View {
        HStack (spacing: 10){
                Button(action: {
                }) {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
                Image(systemName: "pause.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.pause)
                    .clipShape(Circle())
                    .shadow(color: .pauseDropShadow.opacity(1), radius: 0, x: 0, y: 8)
            }
    }
}

#Preview {
    ButtonStarDetail()
}

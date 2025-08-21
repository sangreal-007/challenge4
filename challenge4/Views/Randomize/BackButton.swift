//
//  BackButton.swift
//  challenge4
//
//  Created by Daria Iaparova on 21/08/25.
//

import SwiftUI

struct BackButton: View {
    var onBack: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Button(action: {
                onBack?()
                print("Back button tapped!")
            }) {
                Image(systemName: "chevron.backward")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(16)
                    .background(
                        Circle()
                            .fill(Color(red: 0.09, green: 0.09, blue: 0.35))
                    )
            }
        }
    }
}

#Preview {
    BackButton()
}

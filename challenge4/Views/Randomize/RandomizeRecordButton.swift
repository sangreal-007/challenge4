//
//  StoryRecordButton.swift
//  challenge4
//
//  Created by Daria Iaparova on 21/08/25.
//

import SwiftUI

struct RandomizeRecordButton: View {
    var onNext: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Button(action: {
                print("Recording Started!")
            }) {
                Image(systemName: "microphone.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.microphone)
                    .clipShape(Circle())
                    .shadow(color: .microphoneDropShadow.opacity(1), radius: 0, x: 0, y: 8)
            }
            .padding(.horizontal, 70)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RandomizeRecordButton()
}

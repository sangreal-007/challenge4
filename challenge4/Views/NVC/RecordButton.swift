//
//  RecordButton.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct RecordButton: View {
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
            HStack {
                Spacer()
                Button(action: {
                    onNext?()
                }) {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
            }
            .padding(.horizontal, 70)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RecordButton()
}

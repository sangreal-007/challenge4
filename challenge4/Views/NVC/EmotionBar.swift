//
//  EmotionBar.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//
import SwiftUI

struct EmotionBar: View {
    @Binding var selectedName: String?
    var onNext: (() -> Void)? = nil

    var body: some View {
        ZStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(emotionFace) { face in
                        VStack {
                            Image(face.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .onTapGesture {
                                    selectedName = face.name
                                }
                            
                            Text(face.name)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, -10)
                                .opacity(selectedName == face.name ? 1.0 : 0.5)
                                .fontWeight(selectedName == face.name ? .bold : .regular)
                                .onTapGesture {
                                    selectedName = face.name
                                }
                        }
                    }
                }
            }
            .padding()
            .background(
                Color.emotionBar
                    .clipShape(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 0,
                                bottomLeading: 40,
                                bottomTrailing: 40,
                                topTrailing: 0
                            )
                        )
                    )
            )
            .padding(7)
            
            if let selected = selectedName, !selected.isEmpty {
                Button(action: {
                    onNext?()  // call closure on tap
                }) {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
                .offset(x: 140, y: -80)
                .transition(.opacity)
                .animation(.easeInOut, value: selectedName)
            }
        }
    }
}

#Preview {
    EmotionBar(selectedName: .constant(""))
}

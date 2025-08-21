//
//  EmotionBar.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//
import SwiftUI

struct EmotionBar: View {
    @Binding var observation: RabitFaceObject?
    var onNext: (() -> Void)? = nil
    
    var body: some View {
        ZStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(emotionFace) { face in
                        Button {
                            observation?.image = face.image
                            observation?.name = face.name
                        } label: {
                            VStack {
                                Image(face.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                Text(face.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.top, -10)
                                    .opacity(observation?.name == face.name ? 1.0 : 0.5)
                                    .fontWeight(observation?.name == face.name ? .bold : .regular)
                            }
                        }
                        .buttonStyle(.plain)

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

            if let selected = observation?.name, !selected.isEmpty {
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
                .offset(x: 140, y: -80)
                .transition(.opacity)
                .animation(.easeInOut, value: observation?.name)
            }
        }
    }
}

#Preview {
    @Previewable @State var observation: RabitFaceObject? = RabitFaceObject(name: "", image: "")
    @Previewable @State var isNextActive: Bool = false

    EmotionBar(observation: $observation, onNext: {
        if observation != nil {
            isNextActive = true
        }
    })
}


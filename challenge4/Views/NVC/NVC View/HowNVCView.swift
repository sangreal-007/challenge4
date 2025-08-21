//
//  NVCView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct HowNVCView: View {
    @State private var isNextActive: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var observation: RabitFaceObject? = RabitFaceObject(name: "", image: "")
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack{
                        Text("How do you feel")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack(spacing: 0) {
                            Text("today? ")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Button(action: {
                                print("Megaphone tapped!") // change it into the voice over
                            }) {
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.plain)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    }
                    ZStack {
                        Image("Moon")
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0, y: 251)
                            .allowsHitTesting(false)

                        Image("ShadowOfRabbit")
                            .resizable()
                            .frame(width: 170, height: 70)
                            .offset(x: 0, y:200)
                            .allowsHitTesting(false)

                        Image("RabbitImage")
                            .resizable()
                            .frame(width: 283, height: 345)
                            .offset(x: 0, y: 50)
                            .allowsHitTesting(false)

                        EmotionBar(observation: $observation, onNext: {
                            if observation != nil {
                                isNextActive = true
                            }
                        })
                        .offset(x: 0, y: 290)
                    }

                }
                
            }
            .navigationDestination(isPresented: $isNextActive) {
                WhyNVCView(observation: $observation)
            }
        }

        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.cheveronButton)
                                .clipShape(Circle())
                                .shadow(color: .cheveronDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                        }
                    }
                }
    }
}

#Preview {
    HowNVCView()
}

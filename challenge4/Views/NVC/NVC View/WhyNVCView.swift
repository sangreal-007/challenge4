//
//  HowNVCView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct WhyNVCView:View {
    //Log Object
    @Binding var observation: RabitFaceObject?
    @State var feeling: FeelingObject? = FeelingObject(audioFilePath: "")
    
    @State private var isNextActive: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack{
                        Text("Why do you feel")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack(spacing: 0) {
                            Text("that way? ")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Button(action: {
                                print("Megaphone tapped!") // change it into voice over
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
                    ZStack{
                        Image("Moon")
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0, y: 251)
                        Image("ShadowOfRabbit")
                            .resizable()
                            .frame(width: 170, height: 70)
                            .offset(x: 0, y:200)
                        Image("RabbitImage")
                            .resizable()
                            .frame(width: 283, height: 345)
                            .offset(x: 0, y: 50)
                        RecordButton(feeling: $feeling, onNext: {
                            isNextActive = true
                        })
                            .offset(x: 0, y:270)

                    }
                    
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                NeedNVCView(observation: $observation, feeling: $feeling)
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
    @Previewable @State var observation: RabitFaceObject? = RabitFaceObject(name: "", image: "")
    @Previewable @State var isNextActive: Bool = false

    WhyNVCView(observation: $observation)
}

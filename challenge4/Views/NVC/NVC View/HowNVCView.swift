//
//  NVCView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct HowNVCView: View {
//    // MARK: - Parent
//    @State private var observationParent: RabitFaceObject? = nil
//    @State private var feelingParent: FeelingObject? = nil
//    @State private var needsParent: NeedObject? = nil
//    
//    // MARK: - Child
//    @State private var observationChild: RabitFaceObject? = nil
//    @State private var feelingChild: FeelingObject? = nil
//    @State private var needsChild: NeedObject? = nil
//    
//    // MARK: - Game
//    @State private var answerGame: FeelingObject? = nil
    
    // MARK: - Parent
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?

    // MARK: - Child
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?

    // MARK: - Game
    @Binding var answerGame: FeelingObject?

    @Binding var child: Bool
    
    @State private var isNextActive: Bool = false
    @Environment(\.dismiss) private var dismiss
    
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
                        Image("Rabies")
                            .resizable()
                           .scaledToFit()
                           .scaleEffect(1.7)
                            .offset(x: 0, y: 280)
                            .allowsHitTesting(false)

                        EmotionBar(
                                observationParent: $observationParent,
                                observationChild: $observationChild,
                                child: $child,
                                onNext: {
                                    if !child && observationParent != nil {
                                        isNextActive = true
                                    } else if child && observationChild != nil {
                                        isNextActive = true
                                    }
                                }
                            )
                        
                        .offset(x: 0, y: 290)
                    }
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                WhyNVCView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
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
    @Previewable @State var observationParent: RabitFaceObject? = nil
    @Previewable @State var feelingParent: FeelingObject? = nil
    @Previewable @State var needsParent: NeedObject? = nil
    
    @Previewable @State var observationChild: RabitFaceObject? = nil
    @Previewable @State var feelingChild: FeelingObject? = nil
    @Previewable @State var needsChild: NeedObject? = nil
    
    @Previewable @State var answerGame: FeelingObject? = nil
    
    @Previewable @State var child: Bool = false

    HowNVCView(
        observationParent: $observationParent,
        feelingParent: $feelingParent,
        needsParent: $needsParent,
        observationChild: $observationChild,
        feelingChild: $feelingChild,
        needsChild: $needsChild,
        answerGame: $answerGame,
        child: $child
    )
}

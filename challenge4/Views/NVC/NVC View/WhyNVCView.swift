//
//  HowNVCView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct WhyNVCView:View {
    //Log Object
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    @Binding var answerGame: FeelingObject?
    
    @Binding var child: Bool
    
    @State private var empty: String =  ""
    
    @State private var isNextActive: Bool = false
    let game = ""
    
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
                        RabbitsTalkingView()
                        
                        RecordButton(feelingParent: $feelingParent, feelingChild: $feelingChild, answerGame: $answerGame ,game: $empty, child: $child, onNext: {
                            isNextActive = true
                        })
                            .offset(x: 0, y:270)

                    }
                    
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                NeedNVCView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }
            }
        }

        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            BackButton()
                        }
                    }
                }
    }
}

#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = RabitFaceObject(name: "", image: "")
    @Previewable @State var feelingParent: FeelingObject? = nil
    @Previewable @State var needsParent: NeedObject? = nil
    @Previewable @State var observationChild: RabitFaceObject? = nil
    @Previewable @State var feelingChild: FeelingObject? = nil
    @Previewable @State var needsChild: NeedObject? = nil
    @Previewable @State var answerGame: FeelingObject? = nil
    @Previewable @State var child: Bool = false

    WhyNVCView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
}

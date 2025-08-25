//
//  NeedNVCView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//
import SwiftUI
import SwiftData

struct NeedNVCView: View {
    //Log Object
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    @Binding var answerGame: FeelingObject?
    
    @Binding var child: Bool
    
    @State private var selectedNeeds: [String] = []
    @State private var customNeed: String = ""
    @State private var isNextActive: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack{
                        HStack(spacing: 0) {
                            Text("How do you feel? ")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Button(action: {
                                print("Megaphone tapped!")
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
                    NavigationStack {
                        ZStack {
                            RabbitsTalkingView()
                                .offset(x: 0, y: 22)
                            
                            NeedCard(
                                selectedNeeds: $selectedNeeds,
                                customNeed: $customNeed,
                                child: $child,
                                needChild: $needsChild,
                                needParent: $needsParent,
                                onNext: {
                                    selectedNeeds = []
                                    child = !child
                                    print("Child value: ")
                                    print(child)
                                    isNextActive = true
                                }
                            )
                            .offset(x: 0, y: 270)
                        }
                    }
                    .navigationDestination(isPresented: $isNextActive) {
                        if child {
                            HowNVCView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
                                .transaction { transaction in
                                    transaction.disablesAnimations = true
                                }
                        } else{
                            RandomizeView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
                                .transaction { transaction in
                                    transaction.disablesAnimations = true
                                }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        BackButton()
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = RabitFaceObject(name: "Parent Rabbit", image: "RabbitImage")
    @Previewable @State var feelingParent: FeelingObject? = FeelingObject(name: "" , AudioFilePath: "parent_feeling.m4a")
    @Previewable @State var needsParent: NeedObject? = NeedObject(needs: [""])
    
    @Previewable @State var observationChild: RabitFaceObject? = RabitFaceObject(name: "Child Rabbit", image: "RabbitImage")
    @Previewable @State var feelingChild: FeelingObject? = FeelingObject(name:"" ,AudioFilePath: "child_feeling.m4a")
    @Previewable @State var needsChild: NeedObject? = NeedObject(needs: ["Play"])
    
    @Previewable @State var answerGame: FeelingObject? = FeelingObject(name: "" , AudioFilePath: "game_answer.m4a")
    
    @Previewable @State var child: Bool = false
    
    NeedNVCView(
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

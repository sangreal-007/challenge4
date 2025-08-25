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
                NavigationStack {
                    ZStack {
                        Color.background
                            .ignoresSafeArea()
                        
                        
                        VStack {
                            VStack {
                                VStack {
                                    Text("What do you ")
                                        .font(.largeTitle)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                    HStack(spacing: 0) {
                                        Text("need? ")
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
                                
                                ZStack {
                                    
                                    ZStack {
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
                                        
                                        //                        NeedCard(
                                        //                            selectedNeeds: $selectedNeeds,
                                        //                            customNeed: $customNeed,
                                        //                            chosenNeeds: $needs,
                                        //                            onNext: {
                                        //                                if let obs = observation, let feel = feeling, let finalNeeds = needs {
                                        //                                    let logController = LogController(modelContext: modelContext)
                                        //                                    logController.addLog(observation: obs, feeling: feel, needs: finalNeeds)
                                        //                                    print("✅ Log saved with needs: \(finalNeeds.needs)")
                                        //                                }
                                        //                                selectedNeeds = []
                                        //                                isNextActive = true
                                        //                            }
                                        //                        )
                                        //                        .offset(x: 0, y:270)
                                        
                                        NeedCard(
                                            selectedNeeds: $selectedNeeds,
                                            customNeed: $customNeed,
                                            child: $child,
                                            needChild: $needsChild,
                                            needParent: $needsParent,
                                            onNext: {
                                                selectedNeeds = []
                                                child = !child
                                                print("Child value : ")
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
                                    } else{
                                        RandomizeView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
                                    }
                                }
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: { dismiss() }) {
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

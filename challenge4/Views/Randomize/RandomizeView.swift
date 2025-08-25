//
//  StoryView.swift
//  challenge4
//

import SwiftUI

struct RandomizeView: View {
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    @Binding var answerGame: FeelingObject?
    
    @Binding var child: Bool
    @State var game: String = "game"
    @State private var isNextActive: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    VStack (spacing: 20) {
                        Text("Can you tell me a story\nabout your childhood?")
                            .font(Font.custom("SF Pro Rounded", size: 28))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 8) {
                            Text("Randomize")
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .kerning(0.4)
                                .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
                            
                            Image(systemName: "dice")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
                        }
                    }
                    
                    ZStack {
                        RabbitsTalkingView()
                        
                        RecordButton(
                            feelingParent: $feelingParent,
                            feelingChild: $feelingChild,
                            answerGame: $answerGame,
                            game: $game,
                            child: $child,
                            onNext: {
                                let logController = LogController(modelContext: modelContext)

                                if observationParent != nil || feelingParent != nil || needsParent != nil {
                                    logController.addLog(role: .parent,
                                                         observation: observationParent,
                                                         feeling: feelingParent,
                                                         needs: needsParent)
                                    print("✅ Parent Log saved with obs=\(observationParent != nil), feeling=\(feelingParent != nil), needs=\(needsParent != nil)")
                                }
                                
                                if observationChild != nil || feelingChild != nil || needsChild != nil {
                                    logController.addLog(role: .child,
                                                         observation: observationChild,
                                                         feeling: feelingChild,
                                                         needs: needsChild)
                                    print("✅ Child Log saved with obs=\(observationChild != nil), feeling=\(feelingChild != nil), needs=\(needsChild != nil)")
                                }


                                if answerGame != nil {
                                    logController.addLog(role: .game, feeling: answerGame)
                                    print("🎮 Game Log saved with answer file: \(answerGame?.AudioFilePath ?? "nil")")
                                }

                                // move to next screen
                                isNextActive = true
                            }

                        )
                        .offset(x: 0, y: 270)

                    }
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                // Change into the memory star page
                CalendarView()
//                LogListPage()
                
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

#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = RabitFaceObject(name: "Parent Rabbit", image: "RabbitImage")
    @Previewable @State var feelingParent: FeelingObject? = FeelingObject(name:"",AudioFilePath: "parent_feeling.m4a")
    @Previewable @State var needsParent: NeedObject? = NeedObject(needs: ["Care", "Support"])
    
    @Previewable @State var observationChild: RabitFaceObject? = RabitFaceObject(name: "Child Rabbit", image: "RabbitImage")
    @Previewable @State var feelingChild: FeelingObject? = FeelingObject(name:"" ,AudioFilePath: "child_feeling.m4a")
    @Previewable @State var needsChild: NeedObject? = NeedObject(needs: ["Play", "Fun"])
    
    @Previewable @State var answerGame: FeelingObject? = FeelingObject(name:"",AudioFilePath: "game_answer.m4a")
    
    @Previewable @State var child: Bool = false
    
    RandomizeView(
        observationParent: $observationParent,
        feelingParent: $feelingParent,
        needsParent: $needsParent,
        
        observationChild: $observationChild,
        feelingChild: $feelingChild,
        needsChild: $needsChild,
        
        answerGame: $answerGame,
        child: $child
    )
    .modelContainer(
        for: [LogObject.self, NeedObject.self, RabitFaceObject.self, FeelingObject.self, Item.self],
        inMemory: true
    )

    
}

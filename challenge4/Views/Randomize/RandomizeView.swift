//
//  StoryView.swift
//  challenge4
//
import SwiftUI
import AVFAudio

struct RandomizeView: View {
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    @Binding var answerGame: FeelingObject?
    
    @Binding var child: Bool
    @State var gameName: String = ""
    @State var game: String = "game"
    @State private var isNextActive: Bool = false
    
    @State private var currentQuestion: Question? = nil   // <-- now stores text + audio
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 20) {
                        Text(currentQuestion?.text ?? "Loading...")
                            .font(Font.custom("SF Pro Rounded", size: 28))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)

                        if let audioName = currentQuestion?.audioName {
                            Button {
                                AudioPlayer.shared.playAudio(named: audioName)
                            } label: {
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        HStack(spacing: 8) {
                            Button {
                                let questions = QuestionLoader.loadQuestions()
                                if let randomQ = questions.randomElement() {
                                    currentQuestion = randomQ
                                    gameName = currentQuestion?.text ?? ""
                                }
                            } label: {
                                HStack {
                                    Text("Randomize")
                                    Image(systemName: "dice")
                                }
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
                            }
                            
                            
                        }
                    }
                    
                    ZStack {
                        RabbitsTalkingView()
                        
                        RecordButton(
                            feelingParent: $feelingParent,
                            feelingChild: $feelingChild,
                            answerGame: $answerGame,
                            game: $game, gameName: $gameName,
                            child: $child,
                            onNext: {
                                let logController = LogController(modelContext: modelContext)
                                if observationParent != nil || feelingParent != nil || needsParent != nil ||
                                   observationChild != nil || feelingChild != nil || needsChild != nil ||
                                   answerGame != nil {
                                    
                                    logController.addLog(
                                        observationParent: observationParent,
                                        feelingParent: feelingParent,
                                        needsParent: needsParent,
                                        observationChild: observationChild,
                                        feelingChild: feelingChild,
                                        needsChild: needsChild,
                                        answerGame: answerGame
                                    )
                                }


                                // move to next screen
                                isNextActive = true
                            }
                        )
                        .offset(x: 0, y: 230)
                    }
                }
            }
            .onAppear {
                let questions = QuestionLoader.loadQuestions()
                if let randomQ = questions.randomElement() {
                    currentQuestion = randomQ
                    gameName = currentQuestion?.text ?? ""
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                MemoryStarView()
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

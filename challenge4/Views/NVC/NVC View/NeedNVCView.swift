//
//  NeedNVCView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//
import SwiftUI
import SwiftData

struct NeedNVCView: View {
    // Bindings from parent
    @Binding var observation: RabitFaceObject?
    @Binding var feeling: FeelingObject?
    
    // Local state
    @State private var needs: NeedObject? = NeedObject(needs: [""])
    
    @State private var selectedNeeds: [String] = []
    @State private var customNeed: String = ""
    @State private var isNextActive: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
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
                        
                        NeedCard(
                            selectedNeeds: $selectedNeeds,
                            customNeed: $customNeed,
                            chosenNeeds: $needs,
                            onNext: {
                                if let obs = observation, let feel = feeling, let finalNeeds = needs {
                                    let logController = LogController(modelContext: modelContext)
                                    logController.addLog(observation: obs, feeling: feel, needs: finalNeeds)
                                    print("✅ Log saved with needs: \(finalNeeds.needs)")
                                }
                                selectedNeeds = []
                                isNextActive = true
                            }
                        )
                        .offset(x: 0, y:270)
                    }
                }
                .navigationDestination(isPresented: $isNextActive) {
                    LogListPage()
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



//#Preview {
//    NeedNVCView(
//        observation: .constant(nil),
//        feeling: .constant(nil)
//    )
//}
#Preview {
    @Previewable @State var observation: RabitFaceObject? = RabitFaceObject(name: "", image: "")
    @Previewable @State var feeling: FeelingObject? = FeelingObject(audioFilePath: "")
    
    NeedNVCView(
        observation: $observation,
        feeling: $feeling
    )
    .modelContainer(for: [LogObject.self, NeedObject.self, RabitFaceObject.self, FeelingObject.self], inMemory: true)
}

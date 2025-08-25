//
//  Cards.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//


import SwiftUI

struct Cards: View {
    enum CardState {
        case feeling, why, need, games
    }

    var state: CardState
    
    // 👇 Pass the data directly
    var titleText: String
    var rabitFace: String? = nil
    var imageName: String? = nil
    var audioPathFeeling: String? = nil
    var audioPathGame: String? = nil
    var needs: [String] = []
    
    @StateObject private var audioController = AudioRecorderController()
    
    var body: some View {
        VStack(spacing: 0) {
            Text(titleText)
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .frame(height: 1)

            content
                .padding(2)
        }
        .background(Color("EmotionBarColor"))
        .cornerRadius(20)
        .padding(.horizontal, 5)
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .feeling:
            if let imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 90, height: 90)
            }
            Text(rabitFace ?? "No feeling")
                .foregroundColor(.white)
                .padding(.bottom, 12) 

        case .why:
            if let audioPathFeeling {
                // CHANGE THE BUTTON
                Button(action: {
                    audioController.playRecording(fileName: audioPathFeeling)
                    if let duration = audioController.getRecordingDuration(fileName: audioPathFeeling) {
                        print("Audio duration: \(duration) seconds")
                    }
                }) {
                    Label("Play Game Story", systemImage: "play.circle.fill")
                        .foregroundColor(.white)
                }
                .padding(.bottom, 12)
            } else {
                Text("No reason recorded")
                    .foregroundColor(.gray)
            }
            

        case .need:
            if !needs.isEmpty {
                HStack {
                    ForEach(needs, id: \.self) { need in
                        Text(need)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color("EmotionBarColorDropShadow"))
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 12)
                
            } else {
                Text("No needs logged")
                    .foregroundColor(.gray)
            }

        case .games:
            if let audioPathGame {
                // CHANGE THE BUTTON
                Button(action: {
                    audioController.playRecording(fileName: audioPathGame)
                    if let duration = audioController.getRecordingDuration(fileName: audioPathGame) {
                        print("Audio duration: \(duration) seconds")
                    }
                }) {
                    Label("Play Game Story", systemImage: "play.circle.fill")
                        .foregroundColor(.white)
                }
                .padding(.bottom, 12)
            } else {
                Text("No reason recorded")
                    .foregroundColor(.gray)
                
            }
        }
    }
}

#Preview {
    VStack {
        Cards(
            state: .feeling,
            titleText: "How I'm Feeling Today",
            imageName: "HappyFace"
        )
        Cards(
            state: .why,
            titleText: "Why I Feel That Way",
            audioPathFeeling: "Audio_123.m4a"
        )
        Cards(
            state: .need,
            titleText: "What I Need",
            needs: ["Rest", "Play", "Connection"]
        )
        Cards(
            state: .games,
            titleText: "Can you tell me a story?",
            audioPathGame: "Funny story"
        )
    }
    .padding()
    .background(Color.black)
}


//#Preview {
//    VStack(spacing: 20) {
//        Cards(state: .feeling)
//        Cards(state: .why)
//        Cards(state: .need)
//        Cards(state: .games) // preview for the new Games state
//    }
//    .padding()
//    .background(Color(.systemBackground))
//}

#Preview {
    VStack(spacing: 20) {
        Cards(
            state: .feeling,
            titleText: "How I'm Feeling Today",
            imageName: "HappyFace"
        )
        Cards(
            state: .why,
            titleText: "Why I Feel That Way",
            audioPathFeeling: "Audio_123.m4a"
        )
        Cards(
            state: .need,
            titleText: "What I Need",
            needs: ["Rest", "Play", "Connection"]
        )
        Cards(
            state: .games,
            titleText: "Can you tell me a story?",
            audioPathGame: "Funny story"
        )
    }
    .padding()
    .background(Color.black)
}

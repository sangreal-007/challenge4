//
//  RecordButton.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct RecordButton: View {
    @Binding var feelingParent: FeelingObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var answerGame: FeelingObject?
    @Binding var game: String
    
    @Binding var child: Bool
    
    @StateObject private var recorderController = AudioRecorderController()
    
    var onNext: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Button(action: {
                if recorderController.isRecording {
                    if let filePath = recorderController.stopRecordingWithoutLimit() {
                        print("Recording saved at: \(filePath)")
                        if game == "game" {
                            answerGame = FeelingObject(name:"", AudioFilePath: filePath)
                        } else if child{
                            feelingChild = FeelingObject(name:"", AudioFilePath: filePath)
                        } else {
                            feelingParent = FeelingObject(name:"", AudioFilePath: filePath)
                        }
                    }
                } else {
                    recorderController.requestPermission {
                        recorderController.startRecording()
                    }
                    print("Recording Started!")
                }
            }) {
                Image(systemName: "microphone.fill")
                    .font(.largeTitle)
                    .foregroundColor(recorderController.isRecording ? .red : .white)
                    .padding(20)
                    .background(recorderController.isRecording ? Color.white : Color.microphone)
                    .clipShape(Circle())
                    .shadow(color: .microphoneDropShadow.opacity(1), radius: 0, x: 0, y: 8)
            }

            HStack {
                Spacer()
                Button(action: {
                    onNext?()
                }) {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
            }
            .padding(.horizontal, 70)
            HStack {
                        Button(action: {
                            feelingParent = nil
                            feelingChild = nil
                            answerGame = nil
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(15)
                                .background(Color.trash)
                                .clipShape(Circle())
                                .shadow(color: .trashDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 70)
                }
                .frame(maxWidth: .infinity)
            }
        }

#Preview {
    @Previewable @State var feelingParent: FeelingObject? = nil
    @Previewable @State var feelingChild: FeelingObject? = nil
    @Previewable @State var answerGame: FeelingObject? = nil
    @Previewable @State var game: String = ""
    @Previewable @State var child: Bool = false
    
    RecordButton(
        feelingParent: $feelingParent,
        feelingChild: $feelingChild,
        answerGame: $answerGame,
        game: $game,
        child: $child,
        onNext: {
            print("Next tapped!")
        }
    )
}


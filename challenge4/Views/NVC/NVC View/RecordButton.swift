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
    @Binding var gameName: String
    @Binding var child: Bool
    
    @StateObject private var recorderController = AudioRecorderController()
    
    // NEW
    @State private var showDeletePopup = false
    @State private var pendingDelete: (() -> Void)? = nil
    
    var onNext: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Button(action: {
                if recorderController.isRecording {
                    // STOP RECORDING
                    guard let filePath = recorderController.stopRecordingWithoutLimit() else { return }
                    print("Recording saved at: \(filePath)")
                    
                    switch game {
                    case "game":
                        // Update only game answer
                        if let oldPath = answerGame?.AudioFilePath {
                            try? FileManager.default.removeItem(at: URL(fileURLWithPath: oldPath))
                            print("🗑️ Deleted old game recording at \(oldPath)")
                        }
                        answerGame = FeelingObject(name: gameName, AudioFilePath: filePath)
                        
                    default:
                        // Update parent/child recordings
                        if child {
                            if let oldPath = feelingChild?.AudioFilePath {
                                try? FileManager.default.removeItem(at: URL(fileURLWithPath: oldPath))
                                print("🗑️ Deleted old child recording at \(oldPath)")
                            }
                            feelingChild = FeelingObject(name: "", AudioFilePath: filePath)
                        } else {
                            if let oldPath = feelingParent?.AudioFilePath {
                                try? FileManager.default.removeItem(at: URL(fileURLWithPath: oldPath))
                                print("🗑️ Deleted old parent recording at \(oldPath)")
                            }
                            feelingParent = FeelingObject(name: "", AudioFilePath: filePath)
                        }
                    }
                    
                    BackgroundMusicPlayer.shared.player?.volume = 0.1
                    
                } else {
                    // START RECORDING
                    // Only clear previous recording if not a game
                    if game != "game" {
                        if child, let oldPath = feelingChild?.AudioFilePath {
                            try? FileManager.default.removeItem(at: URL(fileURLWithPath: oldPath))
                            feelingChild = nil
                            print("🗑️ Cleared old child recording")
                        } else if !child, let oldPath = feelingParent?.AudioFilePath {
                            try? FileManager.default.removeItem(at: URL(fileURLWithPath: oldPath))
                            feelingParent = nil
                            print("🗑️ Cleared old parent recording")
                        }
                    } else {
                        // Clear only old game answer
                        if let oldPath = answerGame?.AudioFilePath {
                            try? FileManager.default.removeItem(at: URL(fileURLWithPath: oldPath))
                            answerGame = nil
                            print("🗑️ Cleared old game recording")
                        }
                    }
                    
                    BackgroundMusicPlayer.shared.player?.volume = 0
                    recorderController.requestPermission {
                        recorderController.startRecording()
                        print("Recording Started!")
                    }
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
                    if recorderController.isRecording {
                        guard let filePath = recorderController.stopRecordingWithoutLimit() else { return }
                        print("Recording stopped via Next! Saved at: \(filePath)")
                        
                        switch game {
                        case "game":
                            answerGame = FeelingObject(name: gameName, AudioFilePath: filePath)
                        default:
                            if child {
                                feelingChild = FeelingObject(name: "", AudioFilePath: filePath)
                            } else {
                                feelingParent = FeelingObject(name: "", AudioFilePath: filePath)
                            }
                        }
                        
                        BackgroundMusicPlayer.shared.player?.volume = 0.1
                    }

                    BackgroundMusicPlayer.shared.player?.volume = 0.1
                    print("===== Debug: Before adding log =====")
                    print("feelingParent:", feelingParent?.AudioFilePath ?? "nil")
                    print("feelingChild:", feelingChild?.AudioFilePath ?? "nil")
                    print("answerGame:", answerGame?.AudioFilePath ?? "nil")
                    print("===================================")
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
                if recorderController.isRecording {
                    Button(action: {
                        pendingDelete = {
                            if let tempPath = recorderController.stopRecordingWithoutLimit() {
                                let url = URL(fileURLWithPath: tempPath)
                                try? FileManager.default.removeItem(at: url)
                                print("🗑️ Deleted temp recording at \(url)")
                            }
                        }
                        showDeletePopup = true
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
                    
                } else if let path = feelingParent?.AudioFilePath, game != "game", !child {
                    Button(action: {
                        pendingDelete = {
                            let url = URL(fileURLWithPath: path)
                            try? FileManager.default.removeItem(at: url)
                            print("🗑️ Deleted parent recording at \(url)")
                            feelingParent = nil
                        }
                        showDeletePopup = true
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
                    
                } else if let path = feelingChild?.AudioFilePath, game != "game", child {
                    Button(action: {
                        pendingDelete = {
                            let url = URL(fileURLWithPath: path)
                            try? FileManager.default.removeItem(at: url)
                            print("🗑️ Deleted child recording at \(url)")
                            feelingChild = nil
                        }
                        showDeletePopup = true
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
                    
                } else if let path = answerGame?.AudioFilePath, game == "game" {
                    Button(action: {
                        pendingDelete = {
                            let url = URL(fileURLWithPath: path)
                            try? FileManager.default.removeItem(at: url)
                            print("🗑️ Deleted game recording at \(url)")
                            answerGame = nil
                        }
                        showDeletePopup = true
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
            }
            .padding(.horizontal, 70)
            
            // 👇 Add popup overlay
            PopUpDelete(isPresented: $showDeletePopup) {
                pendingDelete?()
                pendingDelete = nil
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var feelingParent: FeelingObject? = nil
    @Previewable @State var feelingChild: FeelingObject? = nil
    @Previewable @State var answerGame: FeelingObject? = nil
    @Previewable @State var gameName: String = ""
    @Previewable @State var game: String = ""
    @Previewable @State var child: Bool = false
    
    RecordButton(
        feelingParent: $feelingParent,
        feelingChild: $feelingChild,
        answerGame: $answerGame,
        
        game: $game,
        gameName: $gameName,
        child: $child,
        onNext: {
            print("Next tapped!")
        }
    )
}


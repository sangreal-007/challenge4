//
//  RecordButton.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct RecordButton: View {
    @Binding var feeling: FeelingObject?
    @StateObject private var recorderController = AudioRecorderController()
    
    var onNext: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Button(action: {
                if recorderController.isRecording {
                    if let filePath = recorderController.stopRecordingWithoutLimit() {
                        print("Recording saved at: \(filePath)")
                        feeling = FeelingObject(audioFilePath: filePath)
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
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var feeling: FeelingObject? = FeelingObject(audioFilePath: "")
    @Previewable @State var isNextActive: Bool = false

    RecordButton(feeling: $feeling, onNext: {
        if feeling != nil {
            isNextActive = true
        }
    })
}

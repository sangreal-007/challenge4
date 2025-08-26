//
//  BounceButtonStyle.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 25/08/25.
//
import SwiftUI
import AVFoundation

/// A button style that adds a "bouncy" animation when the button is pressed.
struct BounceButtonStyle: ButtonStyle {
    @State private var audioPlayer: AVAudioPlayer?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // Scale down when pressed and animate with a spring effect
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(
                .spring(response: 0.3, dampingFraction: 0.5),
                value: configuration.isPressed
            )
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    playButtonSound()
                }
            }
    }
    
    private func playButtonSound() {
        guard let soundURL = Bundle.main.url(forResource: "bubble-pop-06-351337", withExtension: "mp3") else {
            print("Could not find bubble-pop-06-351337.mp3 file")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
             print("Error playing sound: \(error.localizedDescription)")
         }
     }
 }

 #Preview {
     VStack(spacing: 20) {
         Button("Test Button with Sound") {
             print("Button tapped!")
         }
         .buttonStyle(BounceButtonStyle())
         .padding()
         .background(Color.blue)
         .foregroundColor(.white)
         .cornerRadius(10)
         
         Button("Another Test Button") {
             print("Another button tapped!")
         }
         .buttonStyle(BounceButtonStyle())
         .padding()
         .background(Color.green)
         .foregroundColor(.white)
         .cornerRadius(10)
     }
     .padding()
     .background(Color.gray.opacity(0.1))
 }

//
//  AudioPlayer.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 26/08/25.
//


import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    private var player: AVAudioPlayer?

    func playAudio(named name: String, fileExtension: String = "m4a") {
        if let url = Bundle.main.url(forResource: name, withExtension: fileExtension) {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                print("The VO is starting")
            } catch {
                print("⚠️ Error playing audio \(name): \(error.localizedDescription)")
            }
        } else {
            print("⚠️ Audio file \(name).\(fileExtension) not found in bundle")
        }
    }
}

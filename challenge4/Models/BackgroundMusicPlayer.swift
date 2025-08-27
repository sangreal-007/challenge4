//
//  BackgroundMusicPlayer.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 27/08/25.
//


import AVFoundation

class BackgroundMusicPlayer {
    static let shared = BackgroundMusicPlayer()
    var player: AVAudioPlayer?

    private init() {} // Prevents creating new instances
}

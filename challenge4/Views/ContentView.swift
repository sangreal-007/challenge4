//
//  ContentView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 13/08/25.
//

import SwiftUI
import SwiftData
import AVFoundation

struct ContentView: View {
    @State private var child: Bool = false

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        HomeView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    setupBackgroundMusic()
                }
            }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func setupBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "lullaby", withExtension: "mp3") else {
            print("Could not find background music file")
            return
        }

        do {
            BackgroundMusicPlayer.shared.player = try AVAudioPlayer(contentsOf: url)
            BackgroundMusicPlayer.shared.player?.numberOfLoops = -1
            BackgroundMusicPlayer.shared.player?.volume = 0.1
            BackgroundMusicPlayer.shared.player?.play()
        } catch {
            print("Error playing background music: \(error)")
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(
            for: [LogObject.self, NeedObject.self, RabitFaceObject.self, FeelingObject.self, Item.self],
            inMemory: true
        )
}


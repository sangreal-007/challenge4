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
    
    // MARK: - Parent
    @State private var observationParent: RabitFaceObject? = nil
    @State private var feelingParent: FeelingObject? = nil
    @State private var needsParent: NeedObject? = nil
    
    // MARK: - Child
    @State private var observationChild: RabitFaceObject? = nil
    @State private var feelingChild: FeelingObject? = nil
    @State private var needsChild: NeedObject? = nil

    // MARK: - Game
    @State private var answerGame: FeelingObject? = nil
    
    var body: some View {
        OnboardingViewStart()
            .onAppear {
                setupBackgroundMusic()
            }
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
        
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
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.volume = 0.3 // Set volume to 30%
            audioPlayer?.play()
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


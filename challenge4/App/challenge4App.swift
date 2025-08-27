//
//  challenge4App.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 13/08/25.
//

import SwiftUI
import SwiftData
import AVFoundation

@main
struct challenge4App: App {
    @State private var backgroundAudioPlayer: AVAudioPlayer?
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
            } else {
                OnboardingViewStart()
            }
        }
        .modelContainer(
            for: [LogObject.self, NeedObject.self, RabitFaceObject.self, FeelingObject.self, Item.self],
            inMemory: true
        )
    }
}

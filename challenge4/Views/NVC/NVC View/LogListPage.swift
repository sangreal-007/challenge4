//
//  LogTest.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 21/08/25.
//

// MARK: THIS IS JUST FOR TEST ALR

import SwiftUI
import SwiftData

struct LogListPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var logs: [LogObject] = []
    @StateObject private var audioController = AudioRecorderController()

    var body: some View {
        let logController = LogController(modelContext: modelContext)
        
        NavigationStack {
            List {
                ForEach(logs, id: \.id) { log in
                    VStack(alignment: .leading, spacing: 8) {
                        // Date
                        Text("🗓 \(log.date.formatted(date: .abbreviated, time: .shortened))")
                            .font(.headline)
                        
                        // Observation
                        if let obs = log.observation {
                            Text("Observation: \(obs.name)")
                        }
                        
                        // Feeling with play button
                        if let feeling = log.feeling {
                            HStack {
                                Text("🎵 Feeling (Audio)")
                                    .font(.caption)
                                
                                Button(action: {
                                    audioController.playRecording(fileName: feeling.audioFilePath)
                                }) {
                                    Image(systemName: "play.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                }
                                .buttonStyle(.plain)
                                
                                // Optional: Show current duration
                                Text("\(audioController.currentDuration, specifier: "%.1f")s")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Needs
                        if let needs = log.needs {
                            Text("✅ Needs: \(needs.needs.joined(separator: ", "))")
                        }
                    }
                    .padding(.vertical, 5)
                }
                .onDelete { indexSet in
                    indexSet.map { logs[$0] }.forEach { log in
                        logController.deleteLog(log)
                    }
                    refreshLogs(logController: logController)
                }
            }
            .navigationTitle("Logs")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Log") {
                        addDummyLog(logController: logController)
                    }
                }
            }
            .onAppear {
                refreshLogs(logController: logController)
            }
        }
    }
    
    // MARK: - Helpers
    private func refreshLogs(logController: LogController) {
        logs = logController.fetchLogs()
    }
    
    private func addDummyLog(logController: LogController) {
        let obs = RabitFaceObject(name: "Rabbit", image: "🐰")
        let feeling = FeelingObject(audioFilePath: "sample_audio.m4a") // replace with real recorded file if needed
        let need = logController.addNeed(["Rest", "Connection"])
        
        logController.addLog(observation: obs, feeling: feeling, needs: need)
        refreshLogs(logController: logController)
    }
}

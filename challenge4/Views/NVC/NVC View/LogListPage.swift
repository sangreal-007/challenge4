//
//  LogTest.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 21/08/25.
//
// MARK: - THIS IS JUST FOR TESTING
//

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

                        // PARENT Log
                        if let obs = log.observationParent {
                            Text("👩 Parent Observation: \(obs.name)")
                        }
                        if let feeling = log.feelingParent {
                            logAudioRow(label: "Parent Feeling", fileName: feeling.AudioFilePath)
                        }
                        if let needs = log.needsParent {
                            Text("✅ Parent Needs: \(needs.needs.joined(separator: ", "))")
                        }

                        // CHILD Log
                        if let obs = log.observationChild {
                            Text("🧒 Child Observation: \(obs.name)")
                        }
                        if let feeling = log.feelingChild {
                            logAudioRow(label: "Child Feeling", fileName: feeling.AudioFilePath)
                        }
                        if let needs = log.needsChild {
                            Text("✅ Child Needs: \(needs.needs.joined(separator: ", "))")
                        }

                        // GAME Log
                        if let answer = log.answerGame {
                            logAudioRow(label: "🎮 Game Answer", fileName: answer.AudioFilePath)
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
                    Button("Add Dummy Log") {
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
        logs = logController.fetchLogs(role: .parent) +
               logController.fetchLogs(role: .child) +
               logController.fetchLogs(role: .game)
    }

    private func addDummyLog(logController: LogController) {
        // Example Parent log
        let obs = RabitFaceObject(name: "Rabbit", image: "🐰")
        let feeling = FeelingObject(name:"", AudioFilePath: "sample_audio.m4a")
        let need = NeedObject(needs: ["Rest", "Connection"])

        logController.addLog(role: .parent,
                             observation: obs,
                             feeling: feeling,
                             needs: need)

        // Example Game log
        let gameAnswer = FeelingObject(name: "", AudioFilePath: "game_audio.m4a")
        logController.addLog(role: .game, feeling: gameAnswer)

        refreshLogs(logController: logController)
    }

    // MARK: - UI Component
    @ViewBuilder
    private func logAudioRow(label: String, fileName: String) -> some View {
        HStack {
            Text("🎵 \(label)")
                .font(.caption)

            Button(action: {
                audioController.playRecording(fileName: fileName)
            }) {
                Image(systemName: "play.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            .buttonStyle(.plain)

            // Optional: show playback time
            Text("\(audioController.currentDuration, specifier: "%.1f")s")
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    LogListPage()
        .modelContainer(for: [
            LogObject.self,
            NeedObject.self,
            RabitFaceObject.self,
            FeelingObject.self,
            Item.self // if you’re using Item somewhere else
        ], inMemory: true) // inMemory = test-only, data resets every run
}

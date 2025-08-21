//
//  LogController.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import Foundation
import SwiftData

@MainActor
class LogController: ObservableObject {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - LogObject
    func addLog(observation: RabitFaceObject?, feeling: FeelingObject?, needs: NeedObject) {
        let log = LogObject(observation: observation, feeling: feeling, needs: needs)
        modelContext.insert(log)
        save()
    }
    
    func fetchLogs() -> [LogObject] {
        let descriptor = FetchDescriptor<LogObject>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func deleteLog(_ log: LogObject) {
        modelContext.delete(log)
        save()
    }
    
    // MARK: - NeedObject
    func addNeed(_ newNeeds: [String]) -> NeedObject {
        let need = NeedObject(needs: newNeeds)
        modelContext.insert(need)
        save()
        return need
    }

    func fetchNeeds() -> [NeedObject] {
        let descriptor = FetchDescriptor<NeedObject>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    
    // MARK: - FeelingObject (with audio)
    func addFeeling(audioPath: String) {
        let feeling = FeelingObject(audioFilePath: audioPath)
        modelContext.insert(feeling)
        save()
    }
    
    func fetchFeelings() -> [FeelingObject] {
        let descriptor = FetchDescriptor<FeelingObject>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    // MARK: - Save
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("❌ Failed to save: \(error.localizedDescription)")
        }
    }
}

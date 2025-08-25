//
//  LogController.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import Foundation
import SwiftData

enum LogRole {
    case parent
    case child
    case game
}

@MainActor
class LogController: ObservableObject {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - LogObject
    func addLog(role: LogRole, observation: RabitFaceObject? = nil, feeling: FeelingObject? = nil, needs: NeedObject? = nil) {
        let log: LogObject
        switch role {
        case .parent:
            log = LogObject(
                observationParent: observation,
                feelingParent: feeling,
                needsParent: needs
            )
        case .child:
            log = LogObject(
                observationChild: observation,
                feelingChild: feeling,
                needsChild: needs
            )
        case .game:
            log = LogObject(
                answerGame: feeling
            )
        }
        
        modelContext.insert(log)
        save()
    }
    
    func fetchLogs(role: LogRole) -> [LogObject] {
        let descriptor = FetchDescriptor<LogObject>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        let allLogs = (try? modelContext.fetch(descriptor)) ?? []
        
        switch role {
        case .parent:
            return allLogs.filter { $0.feelingParent != nil || $0.observationParent != nil || $0.needsParent != nil }
        case .child:
            return allLogs.filter { $0.feelingChild != nil || $0.observationChild != nil || $0.needsChild != nil }
        case .game:
            return allLogs.filter { $0.answerGame != nil }
        }
    }
    
    private func fetch(where predicate: Predicate<LogObject>) -> [LogObject] {
        let descriptor = FetchDescriptor<LogObject>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    // MARK: - Parent Fetches
    func fetchParentObservations() -> [LogObject] {
        fetch(where: #Predicate { $0.observationParent != nil })
    }
    
    func fetchParentFeelings() -> [LogObject] {
        fetch(where: #Predicate { $0.feelingParent != nil })
    }
    
    func fetchParentNeeds() -> [LogObject] {
        fetch(where: #Predicate { $0.needsParent != nil })
    }
    
    // MARK: - Child Fetches
    func fetchChildObservations() -> [LogObject] {
        fetch(where: #Predicate { $0.observationChild != nil })
    }
    
    func fetchChildFeelings() -> [LogObject] {
        fetch(where: #Predicate { $0.feelingChild != nil })
    }
    
    func fetchChildNeeds() -> [LogObject] {
        fetch(where: #Predicate { $0.needsChild != nil })
    }
    
    // MARK: - Game Fetch
    func fetchGameAnswers() -> [LogObject] {
        fetch(where: #Predicate { $0.answerGame != nil })
    }
    
    func deleteLog(_ log: LogObject) {
        modelContext.delete(log)
        save()
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

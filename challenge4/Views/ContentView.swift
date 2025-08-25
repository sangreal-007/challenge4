//
//  ContentView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 13/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var child: Bool = false
    
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
        HowNVCView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: [LogObject.self, NeedObject.self, RabitFaceObject.self, FeelingObject.self, Item.self],
            inMemory: true
        )
}


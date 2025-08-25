//
//  LogObject.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import Foundation
import SwiftData

@Model
class LogObject {
    var id: UUID
    var date: Date
    var observationParent: RabitFaceObject?
    var feelingParent: FeelingObject?
    var needsParent: NeedObject?
    var observationChild: RabitFaceObject?
    var feelingChild: FeelingObject?
    var needsChild: NeedObject?
    var answerGame: FeelingObject?
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        
        observationParent: RabitFaceObject? = nil,
        feelingParent: FeelingObject? = nil,
        needsParent: NeedObject? = nil,
        
        observationChild: RabitFaceObject? = nil,
        feelingChild: FeelingObject? = nil,
        needsChild: NeedObject? = nil,
        
        answerGame: FeelingObject? = nil
    ) {
        self.id = id
        self.date = date
        
        self.observationParent = observationParent
        self.feelingParent = feelingParent
        self.needsParent = needsParent
        
        self.observationChild = observationChild
        self.feelingChild = feelingChild
        self.needsChild = needsChild
        
        self.answerGame = answerGame
    }
}

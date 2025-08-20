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
    var observation: RabitFaceObject?
    var feeling: String?
    var needs: [NeedObject]
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        observation: RabitFaceObject? = nil,
        feeling: String? = nil,
        needs: [NeedObject] = []
    ) {
        self.id = id
        self.date = date
        self.observation = observation
        self.feeling = feeling
        self.needs = needs
    }
}


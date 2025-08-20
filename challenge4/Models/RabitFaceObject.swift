//
//  RabitFaceObject.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//
import Foundation
import SwiftData

@Model
class RabitFaceObject {
    var id: UUID
    var name: String
    var image: String
    
    init(id: UUID = UUID(), name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}




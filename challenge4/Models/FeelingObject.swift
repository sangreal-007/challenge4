//
//  FeelingObject.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftData
import Foundation

//@Model
//class FeelingObject: Identifiable {
//    @Attribute(.unique)
//    var id: UUID
//    var audioFilePath: String
//
//    @Relationship(inverse: \RoleObject.feelings)
//    var role: RoleObject?
//    
//    init(audioFilePath: String) {
//        self.id = UUID()
//        self.audioFilePath = audioFilePath
//    }
//}

@Model
class FeelingObject {
    var id: UUID
    var name: String
    var AudioFilePath: String
    
    init(id: UUID = UUID(), name: String,AudioFilePath: String) {
        self.id = id
        self.name = name
        self.AudioFilePath = AudioFilePath
    }
}

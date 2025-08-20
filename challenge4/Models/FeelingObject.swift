//
//  FeelingObject.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftData
import Foundation

@Model
class FeelingObject: Identifiable {
    @Attribute(.unique)
    var id: UUID
    var audioFilePath: String

    init(audioFilePath: String) {
        self.id = UUID()
        self.audioFilePath = audioFilePath
    }
}

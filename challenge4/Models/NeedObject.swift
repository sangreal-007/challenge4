//
//  NeedObject.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftData
import Foundation

@Model
class NeedObject {
    var id: UUID
    var needs: [String]
    
    init(id: UUID = UUID(), needs: [String] = []) {
        self.id = id
        self.needs = needs
    }
}

//
//  Item.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 13/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

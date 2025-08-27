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
    
    struct Need: Identifiable, Codable, Hashable {
        var id: UUID = UUID()
        var text: String
    }

    var needs: [Need]

    init(id: UUID = UUID(), needs: [String] = []) {
        self.id = id
        self.needs = needs.map { Need(text: $0) }
    }
}

//@Model
//class NeedObject {
//    var id: UUID
//    var needsJSON: String
//    
//    var needs: [String] {
//        get {
//            (try? JSONDecoder().decode([String].self, from: Data(needsJSON.utf8))) ?? []
//        }
//        set {
//            if let data = try? JSONEncoder().encode(newValue),
//               let json = String(data: data, encoding: .utf8) {
//                needsJSON = json
//            }
//        }
//    }
//    
//    init(id: UUID = UUID(), needs: [String] = []) {
//        self.id = id
//        if let data = try? JSONEncoder().encode(needs),
//           let json = String(data: data, encoding: .utf8) {
//            self.needsJSON = json
//        } else {
//            self.needsJSON = "[]"
//        }
//    }
//}

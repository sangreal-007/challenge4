//
//  QuestionLoader.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 25/08/25.
//

import SwiftUI

struct Question {
    let text: String
    let audioName: String
}

struct QuestionLoader {
    static func loadQuestions() -> [Question] {
        guard let dataAsset = NSDataAsset(name: "Questions") else {
            print("⚠️ CSV data asset not found in Assets.xcassets")
            return []
        }
        
        guard let csvString = String(data: dataAsset.data, encoding: .utf8) else {
            print("⚠️ Unable to decode CSV data as UTF-8")
            return []
        }
        
        let rows = csvString.components(separatedBy: .newlines)
        print("📄 Found \(rows.count) rows in CSV")
        
        return rows.compactMap { row in
            if row.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return nil // skip empty lines
            }
            
            // Try both tab and comma, just in case
            let columns = row.components(separatedBy: ";")
            if columns.count < 2 {
                print("⚠️ Malformed row: \(row)")
                return nil
            }
            
            let questionText = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let audioBase = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
            let audioName = audioBase
            
            return Question(text: questionText, audioName: audioName)
        }
    }
}

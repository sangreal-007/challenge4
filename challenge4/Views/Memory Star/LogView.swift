//
//  LogView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct LogPage: View {
    let log: LogObject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("🗓 \(log.date.formatted(date: .abbreviated, time: .shortened))")
                .font(.headline)
            
            if let observation = log.observation {
                HStack {
                    Image(observation.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Observed: \(observation.name)")
                        .font(.subheadline)
                }
            }
            
            if let feeling = log.feeling {
                Text("Feeling: \(feeling)")
                    .foregroundColor(.blue)
            }
            
            if !log.needs.isEmpty {
                VStack(alignment: .leading) {
                    Text("Needs:")
                        .font(.headline)
                    ForEach(log.needs) { need in
                        Text("• \(need.title)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    // Sample preview data
    let sampleObservation = RabitFaceObject(name: "Happy", image: "HappyFace")
    let sampleNeeds = [
        NeedObject(title: "Connection"),
        NeedObject(title: "Rest")
    ]
    let sampleLog = LogObject(
        date: .now,
        observation: sampleObservation,
        feeling: "Excited",
        needs: sampleNeeds
    )
    
    return LogPage(log: sampleLog)
}

//
//  LogListPage.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI
import SwiftData

struct LogListPage: View {
    @Query var logs: [LogObject]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(logs) { log in
                    NavigationLink {
                        LogPage(log: log)  
                    } label: {
                        VStack(alignment: .leading) {
                            Text(log.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.headline)
                            if let feeling = log.feeling {
                                Text(feeling)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Logs")
        }
    }
}

#Preview {
    LogListPage()
        .modelContainer(for: [LogObject.self, RabitFaceObject.self, NeedObject.self])
}

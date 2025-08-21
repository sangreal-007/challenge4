//
//  DatePicker.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

struct DatePicker: View {
    @State private var selectedDate = Date()

    var body: some View {
        HStack(spacing: 16) {
            // Left chevron: go to previous day
            Button(action: {
                withAnimation {
                    selectedDate = Calendar.current.date(byAdding: .day,
                                                         value: -1,
                                                         to: selectedDate) ?? selectedDate
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }

            // Date (top) and day name (bottom) with hidden reference text underneath
            ZStack {
                // Your visible date/day
                VStack(spacing: 4) {
                    Text(dateString)
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Text(dayString)
                        .font(.headline)
                        .foregroundColor(.white)
                        .fontWeight(.light)
                }
                // Hidden placeholder: ensures consistent width for longest possible strings
                VStack(spacing: 4) {
                    Text("31")
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Wednesday")
                        .font(.headline)
                        .fontWeight(.light)
                }
                .opacity(0)
            }

            // Right chevron: go to next day
            Button(action: {
                withAnimation {
                    selectedDate = Calendar.current.date(byAdding: .day,
                                                         value: 1,
                                                         to: selectedDate) ?? selectedDate
                }
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }
        }
        .padding()
    }

    /// Two-digit day of month (01, 02, etc.)
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: selectedDate)
    }

    /// Full weekday name (Monday, Tuesday, etc.)
    private var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: selectedDate)
    }
}

#Preview {
    DatePicker()
}

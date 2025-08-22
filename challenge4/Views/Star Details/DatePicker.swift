//
//  DatePicker.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

struct DatePicker: View {
    @Binding var selectedDate: Date
    let onPreviousDay: () -> Void
    let onNextDay: () -> Void
    
    init(selectedDate: Binding<Date>, onPreviousDay: @escaping () -> Void = {}, onNextDay: @escaping () -> Void = {}) {
        _selectedDate = selectedDate
        self.onPreviousDay = onPreviousDay
        self.onNextDay = onNextDay
    }

    var body: some View {
        HStack(spacing: 16) {
            // Left chevron: go to previous day
            Button(action: {
                onPreviousDay()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
//                    .fontWeight(.heavy)
            }

            // Date (top) and day name (bottom) with hidden reference text underneath
            ZStack {
                // Your visible date/day
                VStack(spacing: 2) {
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
                VStack(spacing: 2) {
                    Text("31")
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Wednesday")
                        .font(.headline)
                        .fontWeight(.light)
                }
                .opacity(0)
            }

            // Right chevron: go to next day (disabled if current date is today or later)
            Button(action: {
                onNextDay()
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(isAtPresentDay ? .gray : .white)
//                    .fontWeight(.heavy)
            }
            .disabled(isAtPresentDay)
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
    
    /// Check if selected date is today or later (prevent future navigation)
    private var isAtPresentDay: Bool {
        let calendar = Calendar.current
        return calendar.isDate(selectedDate, inSameDayAs: Date()) || selectedDate > Date()
    }
}

#Preview {
    @State var previewDate = Date()
    return DatePicker(selectedDate: $previewDate, onPreviousDay: {}, onNextDay: {})
}

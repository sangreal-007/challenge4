//
//  CalendarView.swift
//  challenge4
//
//  Created by Levana on 21/08/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 1)) ?? Date()
    private let calendar = Calendar.current
    
    // --- Random completed dates for demo ---
    private let completedDates: Set<Int> = {
        let all = Array(1...31)
        return Set(all.shuffled().prefix(8))
    }()
    
    // Month and Year
    private var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM YYYY"
        return formatter.string(from: currentDate)
    }
    
    // Days in month including leading empty slots
    private var daysInMonth: [Date?] {
        guard let monthRange = calendar.range(of: .day, in: .month, for: currentDate),
              let firstDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start else { return [] }
        
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        
        for day in monthRange {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        return days
    }
    
    // Number of rows (weeks) in this month
    private var numberOfWeeks: Int {
        return Int(ceil(Double(daysInMonth.count) / 7.0))
    }
    
    // --- Helper: check if a date should show a star ---
    private func isCompleted(date: Date) -> Bool {
        let day = calendar.component(.day, from: date)
        return date <= Date() && completedDates.contains(day)
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 7/255, green: 7/255, blue: 32/255).ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("Rock")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()
            
            VStack {
                // Header
                VStack(spacing: 8) {
                    // Top navbar row
                    HStack {
                        BackButton()
                        Spacer()
                        Text("Memory Stars")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        Color.clear.frame(width: 44, height: 44)
                    }
                    Spacer().frame(height: 30)
                    
                    // Month/year row closer to calendar
                    HStack(spacing: 8) {
                        Button(action: {
                            if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
                                currentDate = newDate
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        Text(monthYear)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            if let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
                                currentDate = newDate
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                // Calendar container
                VStack(spacing: 0) {
                    // Days of week header
                    HStack {
                        ForEach(["S","M","T","W","T","F","S"], id: \.self) { day in
                            Text(day)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 118/255, green: 114/255, blue: 255/255))
                                .frame(width: 39, height: 20)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    // Calendar grid (week by week)
                    ForEach(0..<numberOfWeeks, id: \.self) { weekIndex in
                        let weekDays = Array(daysInMonth.dropFirst(weekIndex * 7).prefix(7))
                        
                        ZStack {
                            // Highlight line for past days in this row
                            if let lastPastIndex = weekDays.lastIndex(where: { $0 != nil && $0! < Date() && calendar.isDate($0!, equalTo: currentDate, toGranularity: .month) }) {
                                let firstPastIndex = weekDays.firstIndex(where: { $0 != nil && $0! < Date() && calendar.isDate($0!, equalTo: currentDate, toGranularity: .month) }) ?? lastPastIndex
                                
                                GeometryReader { geo in
                                    let cellWidth = geo.size.width / 7
                                    let xStart = CGFloat(firstPastIndex) * cellWidth
                                    let width = CGFloat(lastPastIndex - firstPastIndex + 1) * cellWidth
                                    
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color(red: 99/255, green: 75/255, blue: 255/255))
                                        .opacity(0.46)
                                        .frame(width: width - 1, height: 45)
                                        .position(x: xStart + width/2, y: geo.size.height/2)
                                }
                            }
                            
                            // Day numbers with stars
                            HStack(spacing: 0) {
                                ForEach(0..<7, id: \.self) { i in
                                    if let date = (i < weekDays.count ? weekDays[i] : nil) {
                                        let dayNumber = calendar.component(.day, from: date)
                                        
                                        ZStack {
                                            if isCompleted(date: date) {
                                                Image("Star")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 40, height: 40)
                                            }
                                            
                                            Text("\(dayNumber)")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        
                                    } else {
                                        Text("")
                                            .frame(maxWidth: .infinity, minHeight: 50)
                                    }
                                }
                            }
                        }
                        .frame(height: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .background(Color(red: 21/255, green: 20/255, blue: 80/255))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    CalendarView()
}

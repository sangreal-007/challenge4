//
//  CalendarContainer.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 22/08/25.
//

import SwiftUI
import SwiftData

struct CalendarContainer: View {
    let currentDate: Date
    let daysInMonth: [Date?]
    let numberOfWeeks: Int
    let logs: [LogObject]
    let isCompleted: (Date) -> Bool
    let getTransition: () -> AnyTransition
    private let calendar = Calendar.current
    
    var body: some View {
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
                                
                                NavigationLink(destination: StarDetailView(selectedDate: date)) {
                                    ZStack {
                                        if isCompleted(date) {
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
                                }
                                .buttonStyle(PlainButtonStyle())
                                
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
        .transition(getTransition())
        .id("\(calendar.component(.year, from: currentDate))-\(calendar.component(.month, from: currentDate))")
    }
}

#Preview {
    let calendar = Calendar.current
    let currentDate = Date()
    let daysInMonth: [Date?] = [nil, nil, nil, Date(), Date(), Date(), Date()]
    
    CalendarContainer(
        currentDate: currentDate,
        daysInMonth: daysInMonth,
        numberOfWeeks: 1,
        logs: [],
        isCompleted: { _ in false },
        getTransition: { .identity }
    )
}

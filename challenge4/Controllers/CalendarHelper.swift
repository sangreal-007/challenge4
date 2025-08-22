//
//  CalendarHelper.swift
//  challenge4
//
//  Created by Levana on 21/08/25.
//
import Foundation
import UIKit
import SwiftUI
import SwiftData

class CalendarHelper
{
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    // Month and Year formatter
    func monthYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM YYYY"
        return formatter.string(from: date)
    }
    
    // Days in month including leading empty slots
    func daysInMonth(date: Date) -> [Date?] {
        guard let monthRange = calendar.range(of: .day, in: .month, for: date),
              let firstDayOfMonth = calendar.dateInterval(of: .month, for: date)?.start else { return [] }
        
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
    func numberOfWeeks(for daysArray: [Date?]) -> Int {
        return Int(ceil(Double(daysArray.count) / 7.0))
    }
    
    // Helper: check if a date should show a star
    func isCompleted(date: Date, logs: [LogObject]) -> Bool {
        return date <= Date() && logs.contains { log in
            calendar.isDate(log.date, inSameDayAs: date)
        }
    }
    
    // Check if current month is the present month (prevent future navigation)
    func isAtPresentMonth(date: Date) -> Bool {
        return calendar.isDate(date, equalTo: Date(), toGranularity: .month)
    }
    
    // Animation direction enum
    enum AnimationDirection {
        case none, left, right
    }
    
    // Get transition animation
    func getTransition(for direction: AnimationDirection) -> AnyTransition {
        switch direction {
        case .left:
            return AnyTransition.asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            )
        case .right:
            return AnyTransition.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            )
        case .none:
            return .identity
        }
    }
    
}


//
//  CalendarView.swift
//  challenge4
//
//  Created by Levana on 21/08/25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentDate = Date()
    @State private var logs: [LogObject] = []
    @State private var animationDirection: CalendarHelper.AnimationDirection = .none
    private let calendar = Calendar.current
    private let calendarHelper = CalendarHelper()
    
    // Month and Year
    private var monthYear: String {
        return calendarHelper.monthYear(date: currentDate)
    }
    
    // Days in month including leading empty slots
    private var daysInMonth: [Date?] {
        return calendarHelper.daysInMonth(date: currentDate)
    }
    
    // Number of rows (weeks) in this month
    private var numberOfWeeks: Int {
        return calendarHelper.numberOfWeeks(for: daysInMonth)
    }
    
    // --- Helper: check if a date should show a star ---
    private func isCompleted(date: Date) -> Bool {
        return calendarHelper.isCompleted(date: date, logs: logs)
    }
    
    // --- Fetch logs when view appears or month changes ---
    private func fetchLogs() {
        let logController = LogController(modelContext: modelContext)
        
        // Fetch *all logs* regardless of role
        let descriptor = FetchDescriptor<LogObject>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        logs = (try? modelContext.fetch(descriptor)) ?? []
    }

    
    // --- Check if current month is the present month (prevent future navigation) ---
    private var isAtPresentMonth: Bool {
        return calendarHelper.isAtPresentMonth(date: currentDate)
    }
    
    // --- Navigation functions with animation ---
    private func goToPreviousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            animationDirection = .left
            withAnimation(.easeInOut(duration: 0.3)) {
                currentDate = newDate
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animationDirection = .none
                fetchLogs()
            }
        }
    }
    
    private func goToNextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate), !isAtPresentMonth {
            animationDirection = .right
            withAnimation(.easeInOut(duration: 0.3)) {
                currentDate = newDate
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animationDirection = .none
                fetchLogs()
            }
        }
    }
    
    // --- Get transition animation ---
    private func getTransition() -> AnyTransition {
        return calendarHelper.getTransition(for: animationDirection)
    }
    
    var body: some View {
        NavigationStack {
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
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        Color.clear.frame(width: 44, height: 44)
                    }
                    Spacer().frame(height: 30)
                    
                    // Month/year row closer to calendar
                    HStack(spacing: 12) {
                        Button(action: {
                            goToPreviousMonth()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title)
//                                .fontWeight(.bold)
                        }
                        .frame(width: 44, height: 44)
                        
                        Text(monthYear)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(minWidth: 120)
                        
                        Button(action: {
                            goToNextMonth()
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(isAtPresentMonth ? .gray : .white)
                                .font(.title)
//                                .fontWeight(.bold)
                        }
                        .frame(width: 44, height: 44)
                        .disabled(isAtPresentMonth)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                // Calendar container
                CalendarContainer(
                    currentDate: currentDate,
                    daysInMonth: daysInMonth,
                    numberOfWeeks: numberOfWeeks,
                    logs: logs,
                    isCompleted: isCompleted,
                    getTransition: getTransition
                )
                
                Spacer()
            }
            }
            .onAppear {
                fetchLogs()
            }
            .onChange(of: currentDate) { _, _ in
                if animationDirection == .none {
                    fetchLogs()
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            // Swipe right - go to previous month
                            goToPreviousMonth()
                        } else if value.translation.width < -threshold {
                            // Swipe left - go to next month
                            goToNextMonth()
                        }
                    }
            )
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CalendarView()
}

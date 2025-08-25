//
//  StarDetailView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI
import SwiftData

// Custom shape with a wavy bottom edge
struct Wave: Shape {
    var baselineFraction: CGFloat
    var amplitudeFraction: CGFloat
    var inverted: Bool = false
    
    @StateObject private var audioController = AudioRecorderController()
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baselineY = rect.height * baselineFraction
        let amplitude = rect.height * amplitudeFraction
        
        // Start at the wave baseline on the left
        path.move(to: CGPoint(x: rect.minX, y: baselineY))
        
        // Draw the sine wave across the width, flipping it if `inverted` is true
        for x in stride(from: 0, through: rect.width, by: 1) {
            let relativeX = x / rect.width
            let waveValue = sin(relativeX * 2 * .pi)
            let y = baselineY + (inverted ? -waveValue : waveValue) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // Connect to the bottom corners
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

struct StarDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedDate: Date
    @State private var logs: [LogObject] = []
    // Track which tab is selected
    @State private var selectedTab: TabBar.Tab = .parent
    @State private var animationDirection: AnimationDirection = .none
    private let calendar = Calendar.current
    
    enum AnimationDirection {
        case none, left, right
    }
    
    init(selectedDate: Date = Date()) {
        _selectedDate = State(initialValue: selectedDate)
    }
    
    // Check if there are logs for the selected date
    private var isCompleted: Bool {
        return logs.contains { log in
            calendar.isDate(log.date, inSameDayAs: selectedDate)
        }
    }
    
    // Check if selected date is today or later (prevent future navigation)
    private var isAtPresentDay: Bool {
        return calendar.isDate(selectedDate, inSameDayAs: Date()) || selectedDate > Date()
    }
    
    // Navigate to previous day
    private func goToPreviousDay() {
        animationDirection = .right
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            fetchLogs()
            animationDirection = .none
        }
    }
    
    // Navigate to next day (only if not at present day)
    private func goToNextDay() {
        guard !isAtPresentDay else { return }
        animationDirection = .left
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            fetchLogs()
            animationDirection = .none
        }
    }

    // Fetch logs from LogController
    private func fetchLogs() {
        let logController = LogController(modelContext: modelContext)

        switch selectedTab {
        case .parent:
            logs = logController.fetchLogs(role: .parent)
        case .child:
            logs = logController.fetchLogs(role: .child)
        case .games:
            logs = logController.fetchLogs(role: .game)
        }
    }


    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // If there's an activity, keep the wave backgrounds;
                // otherwise, show a plain "Background" color.
                if isCompleted {
                    Color("LightOrangeBackground")
                        .ignoresSafeArea()
                    Wave(baselineFraction: 0.33, amplitudeFraction: 0.05, inverted: true)
                        .fill(Color("DarkOrangeBackground"))
                        .ignoresSafeArea()
                } else {
                    Color("Background")
                        .ignoresSafeArea()
                }
            }
            // Top overlay: stays pinned to the top
            .overlay(alignment: .top) {
                VStack(spacing: 16) {
                    // Back button and date picker remain at the top
                    HStack {
                        BackButton()
                            .padding(.leading, 10)
                        DatePicker(selectedDate: $selectedDate, onPreviousDay: goToPreviousDay, onNextDay: goToNextDay)
                            .padding(.leading, -2)
                        Spacer()
                    }
                    
                    // Show the tab bar and cards only when there's activity
    
                    if isCompleted {
                        TabBar(selectedTab: $selectedTab)
                            .padding(.top, -2)
                        
                        VStack(spacing: 12) {
                            if let log = logs.first(where: { calendar.isDate($0.date, inSameDayAs: selectedDate) }) {
                                switch selectedTab {
                                case .parent:
                                    if let observation = log.observationParent {
                                        Cards(state: .feeling, titleText: "How I'm Feeling Today", rabitFace: observation.name, imageName: observation.image)
                                    }
                                    
                                    if let feeling = log.feelingParent {
                                        Cards(state: .why, titleText: "Why I Feel That Way", audioPathFeeling: feeling.AudioFilePath)
                                    }
                                    
                                    if let needs = log.needsParent {
                                        Cards(state: .need, titleText: "What I Need", needs: needs.needs)
                                    }

                                case .child:
                                    if let observation = log.observationChild {
                                        Cards(state: .feeling, titleText: "How I'm Feeling Today", rabitFace: observation.name, imageName: observation.image)
                                    }
                                    
                                    if let feeling = log.feelingChild {
                                        Cards(state: .why, titleText: "Why I Feel That Way", audioPathFeeling: feeling.AudioFilePath)
                                    }
                                    
                                    if let needs = log.needsChild {
                                        Cards(state: .need, titleText: "What I Need", needs: needs.needs)
                                    }
                                case .games:
                                    if log.answerGame != nil {
                                        Cards(state: .games, titleText: log.answerGame!.name, audioPathGame: log.answerGame?.AudioFilePath)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                        .transition(getTransition())
                        .id("completed-\(selectedDate.timeIntervalSince1970)")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            // Bottom overlay: used only when there is no activity
            .overlay(alignment: .bottom) {
                if !isCompleted {
                    NoActivityCard()
                        .padding(.bottom, 100)
                        .padding(.horizontal, 16)
                        .transition(getTransition())
                        .id("no-activity-\(selectedDate.timeIntervalSince1970)")
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            fetchLogs()
        }
        .onChange(of: selectedDate) { _, _ in
            if animationDirection == .none {
                fetchLogs()
            }
        }
        .onChange(of: selectedTab) { newTab in
            fetchLogs()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let threshold: CGFloat = 50
                    if value.translation.width > threshold {
                        // Swipe right - go to previous day
                        goToPreviousDay()
                    } else if value.translation.width < -threshold {
                        // Swipe left - go to next day
                        goToNextDay()
                    }
                }
        )
    }
    
    private func getTransition() -> AnyTransition {
        switch animationDirection {
        case .left:
            return .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            )
        case .right:
            return .asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge: .trailing)
            )
        case .none:
            return .identity
        }
    }
    
}
#Preview {
    StarDetailView(selectedDate: Date())
}

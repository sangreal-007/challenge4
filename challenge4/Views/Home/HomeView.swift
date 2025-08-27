//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import SwiftData
import Lottie

struct HomeView: View {
    // MARK: - State
    @State private var daysCount: Int = 0
    @State private var offsetAmount: CGFloat = -150
    @State private var showHowNVCView = false
    @State private var angle = Angle.zero
    @State private var showFallingStar = false
    @State private var showStarBackground = true
    @State private var starBackgroundOpacity: Double = 1.0
    
    // MARK: - Pass initial clicked state
    @State private var isClicked: Bool
    
    init(isClickedInitially: Bool = false) {
        _isClicked = State(initialValue: isClickedInitially)
        _showFallingStar = State(initialValue: isClickedInitially)
        _showStarBackground = State(initialValue: !isClickedInitially)
        _starBackgroundOpacity = State(initialValue: isClickedInitially ? 0.0 : 1.0)
    }
    
    // MARK: - Parent / Child / Game Bindings
    @State var child: Bool = false
    @State var observationParent: RabitFaceObject? = nil
    @State var feelingParent: FeelingObject? = nil
    @State var needsParent: NeedObject? = nil
    
    @State var observationChild: RabitFaceObject? = nil
    @State var feelingChild: FeelingObject? = nil
    @State var needsChild: NeedObject? = nil
    
    @State var answerGame: FeelingObject? = nil
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \LogObject.date, order: .reverse) private var logs: [LogObject]
    
    private let calendar = Calendar.current
    
    // MARK: - Computed Properties
    private var currentMonthDaysTotal: Int {
        calendar.range(of: .day, in: .month, for: Date())?.count ?? 30
    }
    
    private var completedDaysCount: Int {
        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let monthEnd = calendar.date(byAdding: .month, value: 1, to: monthStart)!
        
        return logs.filter { log in
            log.date >= monthStart && log.date < monthEnd
        }.count
    }
    
    // MARK: - Functions
    private func checkTodayLog() {
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let todayLogExists = logs.contains { log in
            log.date >= startOfDay && log.date < endOfDay
        }
        
        isClicked = todayLogExists
        daysCount = completedDaysCount
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .offset(x: offsetAmount, y: -30)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration:4 ).repeatForever(autoreverses: false)) {
                            offsetAmount = 500
                        }
                    }
                
                // Star Background
                if showStarBackground {
                    StarBackground(starImageName: "StarHome", count: daysCount, minSize: 10, maxSize: 26)
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
                        .rotationEffect(angle)
                        .opacity(starBackgroundOpacity)
                        .onAppear {
                            withAnimation(.linear(duration: 16).repeatForever(autoreverses: false)) {
                                angle = .degrees(360)
                            }
                        }
                }
                
                // Falling Star Animation
                if showFallingStar {
                    FallingStar()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                                showFallingStar = false
                                showStarBackground = true
                                withAnimation(.easeIn(duration: 1.0)) {
                                    starBackgroundOpacity = 1.0
                                }
                            }
                        }
                }
                
                // Moon & Rabbits Layer
                Image("FullMoon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 79, height: 79)
                    .zIndex(1)
                    .offset(x: 80, y:-150)
                
                VStack {
                    Image("MoonBase")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 440, height: 246)
                        .offset(y: 300)
                        .ignoresSafeArea(.all)
                }
                
                // Progress bar
                ProgressBarView(
                    daysCount: completedDaysCount,
                    daysTotal: currentMonthDaysTotal
                )
                .offset(x: -105, y: -335)
                
                // Rabbits
                VStack {
                    ZStack {
                        Image("ChildStone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 210.32, height: 69)
                            .offset(x:150,y:210)
                        
                        LottieView(name: "rabbit talk child", loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                            .frame(width: 134, height: 173)
                            .scaleEffect(0.14)
                            .offset(x:80, y: 120)
                        
                        Image("ParentStone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 99.84, height: 65.69)
                            .offset(x:-18,y:205)
                        LottieView(name: "rabbit talk mom", loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                            .frame(width: 163, height: 207)
                            .scaleEffect(0.17)
                            .offset(x:50, y: 110)
                    }
                }.frame(maxWidth: 353, alignment: .topLeading)
                
                // Talk to Rabbit Button
                VStack {
                    Spacer()
                    TalkToRabbitBtn(showHowNVCView: $showHowNVCView, isClicked: $isClicked)
                        .offset(x: 0, y: 20)
                }
                .padding(.bottom, 120)
                .opacity(starBackgroundOpacity)
                .navigationDestination(isPresented: $showHowNVCView) {
                    HowNVCView(
                        observationParent: $observationParent,
                        feelingParent: $feelingParent,
                        needsParent: $needsParent,
                        observationChild: $observationChild,
                        feelingChild: $feelingChild,
                        needsChild: $needsChild,
                        answerGame: $answerGame,
                        child: $child
                    )
                }
            }
            .onAppear {
                checkTodayLog()
            }
            .background(Color("AppBg"), ignoresSafeAreaEdges: .all)
        }
    }
}


#Preview {
    HomeView()
}

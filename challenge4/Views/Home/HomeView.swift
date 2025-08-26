//
//  HomeView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie

struct HomeView: View {
    @State private var daysCount : Int = 7
    @State private var daysTotal: Int = 30
    @State private var offsetAmount : CGFloat = -150
    @State private var showHowNVCView = false
    @State private var isClicked = false
    @State private var angle = Angle.zero
    @State private var showFallingStar = false
    @State private var showStarBackground = true
    @State private var starBackgroundOpacity: Double = 1.0
//    @State private var isClicked = false
    
    init(isClickedInitially: Bool = false) {
        _isClicked = State(initialValue: isClickedInitially)
        // If coming from MemoryStarView (isClickedInitially is true), show falling star animation
        _showFallingStar = State(initialValue: isClickedInitially)
        _showStarBackground = State(initialValue: !isClickedInitially)
        _starBackgroundOpacity = State(initialValue: isClickedInitially ? 0.0 : 1.0)
    }

// MARK: - Parent
    @State private var child: Bool = false
    
    // MARK: - Parent
    @State private var observationParent: RabitFaceObject? = nil
    @State private var feelingParent: FeelingObject? = nil
    @State private var needsParent: NeedObject? = nil
    
    // MARK: - Child
    @State private var observationChild: RabitFaceObject? = nil
    @State private var feelingChild: FeelingObject? = nil
    @State private var needsChild: NeedObject? = nil

    // MARK: - Game
    @State private var answerGame: FeelingObject? = nil
    
    var body: some View { 
        NavigationStack{
            ZStack{
                //First Layer
                VStack{
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .offset(x:offsetAmount, y: -30)
                        .ignoresSafeArea()
                        .onAppear {
                            withAnimation(.linear(duration:4 ).repeatForever(autoreverses: false)) {
                                offsetAmount = 500 // Adjust as needed
                            }
                        }
                    
                }
                
                //Second Layer
//                RotatingStars()
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
                
                if showFallingStar {
                    FallingStar()
                        .onAppear {
                            // After FallingStar animation completes (1.2s + 0.5s + 0.7s = 2.4s), re-enable StarBackground
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                                showFallingStar = false
                                showStarBackground = true
                                // Animate fade-in of StarBackground
                                withAnimation(.easeIn(duration: 1.0)) {
                                    starBackgroundOpacity = 1.0
                                }
                            }
                        }
                }
                
                //Third Layer
                Image("FullMoon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 79, height: 79)
                    .zIndex(1)
                    .offset(x: 80, y:-150)
                
                //Fourth Layer
                VStack {
                    Image("MoonBase")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 440, height: 246)
                        .offset(y: 300 )
                        .ignoresSafeArea(.all)
                }
                
                
                //Fifth Layer
                ProgressBarView()
                    .offset(x: -85, y: -335)
                
                
                //6th Layer
                VStack{
                    
                    ZStack {
                        Image("ChildStone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 210.32, height: 69)
                            .offset(x:150,y:210)
                        LottieView(name: "rabbit talk child", // the name is the name of the .json file
                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                        .frame(width: 134, height: 173)
                        .scaleEffect(0.14)
                        .offset(x:80, y: 120)
                        
                        Image("ParentStone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 99.84, height: 65.69)
                            .offset(x:-18,y:205)
                        LottieView(name: "rabbit talk mom", // the name is the name of the .json file
                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
                        .frame(width: 163, height: 207)
                        .scaleEffect(0.17)
                        .offset(x:50, y: 110)
                        
                    }
                    
                }.frame(maxWidth: 353, alignment: .topLeading)
                
                //7th Layer
                VStack{
                    Spacer()
                    TalkToRabbitBtn ( showHowNVCView: $showHowNVCView, isClicked: $isClicked)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 120, trailing: 0))
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
          
        }.background(Color("AppBg"), ignoresSafeAreaEdges: .all)
    }
}


//struct HomeViewEnd : View{
//    var body: some View{
//        
//    }
//    
//    
//}

#Preview {
    HomeView()
}

//
//  NVCView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI
import Lottie

struct HowNVCView: View {
    //    // MARK: - Parent
    //    @State private var observationParent: RabitFaceObject? = nil
    //    @State private var feelingParent: FeelingObject? = nil
    //    @State private var needsParent: NeedObject? = nil
    //
    //    // MARK: - Child
    //    @State private var observationChild: RabitFaceObject? = nil
    //    @State private var feelingChild: FeelingObject? = nil
    //    @State private var needsChild: NeedObject? = nil
    //
    //    // MARK: - Game
    //    @State private var answerGame: FeelingObject? = nil
    
    // MARK: - Parent
    @Binding var observationParent: RabitFaceObject?
    @Binding var feelingParent: FeelingObject?
    @Binding var needsParent: NeedObject?
    
    // MARK: - Child
    @Binding var observationChild: RabitFaceObject?
    @Binding var feelingChild: FeelingObject?
    @Binding var needsChild: NeedObject?
    
    // MARK: - Game
    @Binding var answerGame: FeelingObject?
    
    @Binding var child: Bool
    
    @State private var isNextActive: Bool = false
    @State private var ellipseScale: CGFloat = 10.0 // Animation state for parent's turn
    @State private var showParentCard: Bool = false // Controls ParentsTurnCard visibility
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack{
                        Text("How do you feel")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack(spacing: 0) {
                            Text("today? ")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Button(action: {
                                print("Megaphone tapped!") // change it into the voice over
                            }) {
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.plain)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    }
                    ZStack {
                        // Parent's Turn Card - positioned above RabbitsTalkingView
                        if !child {
                            ParentsTurnCard()
                                .offset(x: -70, y: -140)
                                .opacity(showParentCard ? 1.0 : 0.0)
                                .animation(.easeInOut(duration: 1.0), value: showParentCard)
                        }
                        
                        RabbitsTalkingView()
                        
                        EmotionBar(
                            observationParent: $observationParent,
                            observationChild: $observationChild,
                            child: $child,
                            onNext: {
                                if !child && observationParent != nil {
                                    isNextActive = true
                                } else if child && observationChild != nil {
                                    isNextActive = true
                                }
                            }
                        )
                        
                        .offset(x: 0, y: 290)
                    }
                }
                
                // Animation overlay for parent's turn only - covers entire view
                
                // Black tint with animated ellipse cutout
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .ignoresSafeArea(.all)
                    .allowsHitTesting(false)
                    .mask {
                        Rectangle()
                            .ignoresSafeArea(.all)
                            .overlay {
                                Ellipse()
                                    .frame(width: 240 * ellipseScale, height: 300 * ellipseScale)
                                    .offset(x: -70, y: 10)
                                    .blendMode(.destinationOut)
                            }
                    }
                
                // Invisible overlay for tap gesture to skip animation
                if !child && ellipseScale != 10.0 {
                    Rectangle()
                        .fill(Color.clear)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            // Skip animation - hide card and expand ellipse
                            showParentCard = false
                            withAnimation(.easeInOut(duration: 2.0)) {
                                ellipseScale = 10.0
                            }
                        }
                }
            }
            .onAppear {
                if !child {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        ellipseScale = 1.0
                    }
                    
                    // Show ParentsTurnCard after 1.5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showParentCard = true
                    }
                    
                    // Auto-reverse after 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        showParentCard = false
                        withAnimation(.easeInOut(duration: 2.0)) {
                            ellipseScale = 10.0
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isNextActive) {
                WhyNVCView(observationParent: $observationParent, feelingParent: $feelingParent, needsParent: $needsParent, observationChild: $observationChild, feelingChild: $feelingChild, needsChild: $needsChild, answerGame: $answerGame, child: $child)
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    BackButton()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var observationParent: RabitFaceObject? = nil
    @Previewable @State var feelingParent: FeelingObject? = nil
    @Previewable @State var needsParent: NeedObject? = nil
    
    @Previewable @State var observationChild: RabitFaceObject? = nil
    @Previewable @State var feelingChild: FeelingObject? = nil
    @Previewable @State var needsChild: NeedObject? = nil
    
    @Previewable @State var answerGame: FeelingObject? = nil
    
    @Previewable @State var child: Bool = false
    
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

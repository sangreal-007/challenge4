//
//  StoryView.swift
//  challenge4
//

import SwiftUI

struct RandomizeView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    VStack (spacing: 20) {
                        Text("Can you tell me a story\nabout your childhood?")
                            .font(Font.custom("SF Pro Rounded", size: 28))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 8) {
                            Text("Randomize")
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .kerning(0.4)
                                .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
                            
                            Image(systemName: "dice")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.46, green: 0.45, blue: 1))
                        }
                    }
                    
                    ZStack {
                        Image("Moon")
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0, y: 251)
                        
                        Image("StoneBig")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                            .offset(x: -100, y: 160)
                        
                        Image("StoneWide")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240)
                            .offset(x: 80, y: 160)
                        
                        Image("RabbitGrown")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360)
                            .offset(x: -10, y: 60)
                        
                        Image("RabbitChild")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280)
                            .offset(x: 10, y: 80)
                        
                        RandomizeRecordButton()
                            .scaleEffect(1.1)
                            .offset(x: 0, y: 272)
                    }
                }
            }
            .overlay(alignment: .topLeading) {
                BackButton(onBack: {
                    dismiss()
                })
                .padding(.top, 20)
                .padding(.leading, 20)
                .scaleEffect(1.2)
                .zIndex(10)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RandomizeView()
}

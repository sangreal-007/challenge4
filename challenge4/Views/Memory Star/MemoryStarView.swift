//
//  MemoryStarView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 19/08/25.
//

import SwiftUI

struct MemoryStarView: View {
    @State private var daysCount : Int = 0
    @State private var daysTotal: Int = 30
    @State private var offsetAmount : CGFloat = -150
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            ZStack{
            //First Layer
            VStack{
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth:.infinity , maxHeight: .infinity)
                    .clipped()
                    .offset(x: offsetAmount, y: -20)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                            offsetAmount = 500 // Adjust as needed
                        }
                    }
                
            }
            
            Image("FullMoon")
                .resizable()
                .scaledToFit()
                .frame(width: 79, height: 79)
                .offset(x: 98, y:-150)
                .zIndex(1)
            
            //Second Layer
//            VStack {
//                Image("MoonBase")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 440, height: 246)
//                    .offset(y: 300 )
//                    .ignoresSafeArea(.all)
//            }
            
            //Third Layer
            VStack{
                
                HStack(spacing:-50){
                    ZStack {
                        RabbitStarView()
                            .frame(maxWidth: 393, maxHeight: 552, alignment: .bottom)

                    }
                    
                }
                
                
            }
            
            //FourthLayer
            VStack {
                Spacer()
                HStack {
                    Text("You Collect")
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                        .offset(x: 5, y:0)
                    Text("Memory")
                        .font(.system(size:28, design: .rounded ))
                        .fontWeight(.regular)
                        .foregroundStyle(Color("MemoryFontColor"))
                        .offset(x: 5, y:0)
                }
                HStack {
                    Text("Star")
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.regular)
                        .foregroundStyle(Color("MemoryFontColor"))
                        .offset(x: 5, y:0)
                    Text("together")
                        .font(.system(size:28, design: .rounded ))
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                        .offset(x: 5, y:0)
                }
            }.padding(.bottom, 40)
            
            
            }
            .onAppear {
                // Add 12-second delay before navigating to HomeView
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    navigateToHome = true
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView(isClickedInitially: true)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MemoryStarView()
}

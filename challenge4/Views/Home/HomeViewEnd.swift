////
////  HomeViewEnd.swift
////  challenge4
////
////  Created by Ardelia on 26/08/25.
////
//
//import SwiftUI
//import Lottie
//
//
//
//struct HomeViewEnd: View {
//    @State private var daysCount : Int = 7
//    @State private var daysTotal: Int = 30
//    @State private var offsetAmount : CGFloat = -150
//    @State private var showHowNVCView = false
//    @State private var angle = Angle.zero
//    @State private var isClicked = false
//    
//    var body: some View {
//        NavigationStack{
//            ZStack{
//                //First Layer
//                VStack{
//                    Image("Background")
//                        .resizable()
//                        .scaledToFill()
//                        .clipped()
//                        .offset(x:offsetAmount, y: -30)
//                        .ignoresSafeArea()
//                        .onAppear {
//                            withAnimation(.linear(duration:4 ).repeatForever(autoreverses: false)) {
//                                offsetAmount = 500 // Adjust as needed
//                            }
//                        }
//                    
//                }
//                
//                //Second Layer
////                RotatingStars()
//                StarBackground(starImageName: "StarHome", count: daysCount, minSize: 10, maxSize: 26)
//                    .frame(width: UIScreen.main.bounds.width,
//                           height: UIScreen.main.bounds.height)
//                    .rotationEffect(angle)
//                    .onAppear {
//                        withAnimation(.linear(duration: 16).repeatForever(autoreverses: false)) {
//                            angle = .degrees(360)
//                        }
//                    }
//                
//                //Third Layer
//                Image("FullMoon")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 79, height: 79)
//                    .zIndex(1)
//                    .offset(x: 80, y:-150)
//                
//                //Fourth Layer
//                VStack {
//                    Image("MoonBase")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 440, height: 246)
//                        .offset(y: 300 )
//                        .ignoresSafeArea(.all)
//                }
//                
//                
//                //Fifth Layer
//                ZStack() {
//                    Image("ProgressBar")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 177, height: 65)
//                    
//                    HStack(spacing: 0) {
//                        Text ("\(daysCount)")
//                            .font(.title)
//                            .fontDesign(.rounded)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.white)
//                            .offset(x: 58, y:-6)
//                        Text("\\\\\(daysTotal)")
//                            .font(.title)
//                            .fontDesign(.rounded)
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.center)
//                            .foregroundStyle(
//                                .white
//                                    .opacity(0.3))
//                            .offset(x: 58, y:-6)
//                    }.frame(maxWidth:148, alignment: .topLeading)
//                }.frame(width: 353, height: 70, alignment: .topLeading)
//                    .padding(EdgeInsets(top:-360, leading:20, bottom: 8, trailing: 20))
//                
//                
//                //6th Layer
//                VStack{
//                    
//                    ZStack {
//                        Image("ChildStone")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 210.32, height: 69)
//                            .offset(x:150,y:210)
//                        LottieView(name: "rabbit talk child", // the name is the name of the .json file
//                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
//                        .frame(width: 134, height: 173)
//                        .scaleEffect(0.14)
//                        .offset(x:80, y: 120)
//                        
//                        Image("ParentStone")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 99.84, height: 65.69)
//                            .offset(x:-18,y:205)
//                        LottieView(name: "rabbit talk mom", // the name is the name of the .json file
//                                   loopMode: .loop, contentMode: .scaleAspectFit, speed: 1.0)
//                        .frame(width: 163, height: 207)
//                        .scaleEffect(0.17)
//                        .offset(x:50, y: 110)
//                        
//                    }
//                    
//                }.frame(maxWidth: 353, alignment: .topLeading)
//                
//                //7th Layer
//                VStack{
//                    Spacer()
//                    TalkToRabbitBtn ( showHowNVCView: $showHowNVCView, isClicked : $isClicked)
//                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 120, trailing: 0))
//                
//                
//               
//                    .navigationDestination(isPresented: $showHowNVCView) {
////                        HowNVCView()
//                    }
//                
//                
//            }
//          
//        }.background(Color("AppBg"), ignoresSafeAreaEdges: .all)
//    }
//}
//
//#Preview {
//    HomeViewEnd()
//}

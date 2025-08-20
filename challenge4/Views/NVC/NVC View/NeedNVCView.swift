//
//  NeedNVCView.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct NeedNVCView: View {
    @State private var selectedNeed: String? = nil
    @State private var customNeed: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack{
                        Text("What do you ")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack(spacing: 0) {
                            Text("need? ")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Button(action: {
                                print("Megaphone tapped!")
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
                    ZStack{
                        Image("Moon")
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0, y: 251)
                        Image("ShadowOfRabbit")
                            .resizable()
                            .frame(width: 170, height: 70)
                            .offset(x: 0, y:200)
                        Image("RabbitImage")
                            .resizable()
                            .frame(width: 283, height: 345)
                            .offset(x: 0, y: 50)
                        NeedCard(
                            selectedNeed: $selectedNeed,
                            customNeed: $customNeed
                        )
                            .offset(x: 0, y:270)
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.cheveronButton)
                                .clipShape(Circle())
                                .shadow(color: .cheveronDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                        }
                    }
                }
    }
}

#Preview {
    NeedNVCView()
}

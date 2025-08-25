//
//  NeedCard.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct NeedCard: View {
    let needss = ["Rest", "Sleep", "Eat", "Play", "Relax", "Exercise", "Connect"]
    @Binding var selectedNeeds: [String]
    @Binding var customNeed: String
    @Binding var child: Bool
    @Binding var needChild: NeedObject?
    @Binding var needParent: NeedObject?
    var onNext: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Needs")
                        .font(.title)
                        .foregroundColor(.white)
                    Image(systemName: "list.bullet")
                        .font(.title)
                        .foregroundColor(.white)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(needss, id: \.self) { need in
                            Text(need)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.needsButton)
                                .cornerRadius(12)
                                .opacity(selectedNeeds.contains(need) ? 1.0 : 0.5) // highlight if selected
                                .onTapGesture {
                                    if selectedNeeds.contains(need) {
                                        selectedNeeds.removeAll { $0 == need } // unselect
                                    } else {
                                        selectedNeeds.append(need) // select
                                    }
                                }
                                .animation(.easeInOut(duration: 0.2), value: selectedNeeds)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        TextField(
                            "",
                            text: $customNeed,
                            prompt: Text("Type your need...")
                                .foregroundColor(.white.opacity(0.5))
                        )
                        .foregroundColor(.white)

                        Button(action: {
                            customNeed = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")  
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding()
                    .background(Color.needsButton)
                    .cornerRadius(20)
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 16)
            .padding(.bottom, 40)
            .background(
                Color.emotionBar
                    .clipShape(
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 0,
                                bottomLeading: 40,
                                bottomTrailing: 40,
                                topTrailing: 0
                            )
                        )
                    )
            )

            if !selectedNeeds.isEmpty || !customNeed.isEmpty {
                Button(action: {
                    print("✅ Confirm needs")
                    if !customNeed.isEmpty {
                        selectedNeeds.append(customNeed)
                        customNeed = ""
                    }
                    if child {
                        if needChild == nil {
                            needChild = NeedObject(needs: selectedNeeds)
                        } else {
                            needChild?.needs = selectedNeeds
                        }
                    } else {
                        if needParent == nil {
                            needParent = NeedObject(needs: selectedNeeds)
                        } else {
                            needParent?.needs = selectedNeeds
                        }
                    }
                    onNext?()
                }) {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
                .offset(x: 140, y: -110)
            }

        }
    }
}

//#Preview {
//    @Previewable @State var selectedNeeds: [String] = [""]
//    @Previewable @State var customNeed: String = ""
//    @Previewable @State var needs: NeedObject? = NeedObject(needs: [""])
//    
//    NeedCard(selectedNeeds: $selectedNeeds, customNeed: $customNeed, chosenNeeds: $needs)
//}

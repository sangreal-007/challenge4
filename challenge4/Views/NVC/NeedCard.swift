//
//  NeedCard.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftUI

struct NeedCard: View {
    let needs = ["Play", "Sleep", "Talk", "Help", "Love"]
    @Binding var selectedNeeds: [String]
    @Binding var customNeed: String
    @Binding var child: Bool
    @Binding var needChild: NeedObject?
    @Binding var needParent: NeedObject?
    var onNext: (() -> Void)? = nil
    
    @State private var showNeedsPopup = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // Title
                HStack {
                    Text("Needs")
                        .font(.title).bold()
                        .foregroundColor(.white)
                    
                    Button(action: {
                        showNeedsPopup = true
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.title)
                            .foregroundColor(.white)
                    }.transition(.opacity)
                }

                // Chips for needs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(needs, id: \.self) { need in
                            Text(need)
                                .font(.title2).bold() // bigger font
                                .foregroundColor(.white)
                                .padding(.vertical, 12) // more padding
                                .padding(.horizontal, 20)
                                .background(Color.needsButton)
                                .cornerRadius(20) // more rounded
                                .opacity(selectedNeeds.contains(need) ? 1.0 : 0.5)
                                .onTapGesture {
                                    if selectedNeeds.contains(need) {
                                        selectedNeeds.removeAll { $0 == need }
                                    } else {
                                        selectedNeeds.append(need)
                                    }
                                }
                                .animation(.easeInOut(duration: 0.2), value: selectedNeeds)
                        }
                    }
                }
                
                // Custom need input
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        TextField(
                            "",
                            text: $customNeed,
                            prompt: Text("Other type here....") // updated placeholder
                                .foregroundColor(.white.opacity(0.5))
                        )
                        .font(.title3) // bigger font
                        .foregroundColor(.white)
                        .focused($isTextFieldFocused)

                        Button(action: {
                            customNeed = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title) // slightly bigger icon
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color.needsButton)
                    .cornerRadius(30) // rounder pill shape
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

            // Confirm button
            if !selectedNeeds.isEmpty || !customNeed.isEmpty {
                Button(action: {
                    print("✅ Confirm needs")
                    if !customNeed.isEmpty {
                        selectedNeeds.append(customNeed)
                        customNeed = ""
                    }
                    let mappedNeeds = selectedNeeds // already [String]

                    if child {
                        if needChild == nil {
                            needChild = NeedObject(needs: mappedNeeds)
                        } else {
                            needChild?.needs = mappedNeeds.map { NeedObject.Need(text: $0) }
                        }
                    } else {
                        if needParent == nil {
                            needParent = NeedObject(needs: mappedNeeds)
                        } else {
                            needParent?.needs = mappedNeeds.map { NeedObject.Need(text: $0) }
                        }
                    }

                    onNext?()
                }) {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(18)
                        .background(Color.checkmark)
                        .clipShape(Circle())
                        .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 8)
                }
                .offset(x: 140, y: -110)
                .buttonStyle(BounceButtonStyle())
            }
            
            // PopUp overlay
            PopUpNeeds(isPresented: $showNeedsPopup)
        }
        .onTapGesture {
            // Dismiss keyboard when tapping outside
            isTextFieldFocused = false
        }
    }
}

#Preview {
    @Previewable @State var selectedNeeds: [String] = []
    @Previewable @State var customNeed: String = ""
    @Previewable @State var child: Bool = false
    @Previewable @State var needChild: NeedObject? = nil
    @Previewable @State var needParent: NeedObject? = nil
    
    NeedCard(selectedNeeds: $selectedNeeds, customNeed: $customNeed, child: $child, needChild: $needChild, needParent: $needParent)
}

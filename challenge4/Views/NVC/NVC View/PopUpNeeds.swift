//
//  PopUpNeeds.swift
//  challenge4
//
//  Created by Levana on 25/08/25.
//

import SwiftUI

struct PopUpNeeds: View {
    @State private var selectedNeeds: [String] = []
    
    let needs = ["Rest", "Cooperation", "Understanding", "Focus", "Support"]
    
    var body: some View {
        VStack(spacing: 10) {
            // Header
            HStack {
                Text("Needs")
                    .font(.title2).bold()
                    .foregroundColor(.white)
                
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundColor(.bulletList)
                
                Spacer()
                
                Button(action: {
                    // Close action
                }) {
                    Image(systemName: "xmark")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Circle().fill(Color.cancelButton)
                        )
                }
            }
            .padding(.horizontal)
            
            // Needs Chips
            FlowLayout(needs, id: \.self) { need in
                Button(action: {
                    toggleNeed(need)
                }) {
                    Text(need)
                        .fontWeight(selectedNeeds.contains(need) ? .bold : .regular)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.cancelButton)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            
            // Done Button
            Button(action: {
            }) {
                HStack {
                    Text("Done")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 135)
                .padding(.vertical, 15)
                .background(Color.checkmark) // your custom asset
                .clipShape(Capsule())
                .shadow(color: .checkmarkDropShadow.opacity(1), radius: 0, x: 0, y: 6)
            }
            .padding(.bottom, 25)
        }
        .padding(.top, 20)
        .background(Color.popUpBackground)
        .cornerRadius(20)
        .padding()
    }
    
    private func toggleNeed(_ need: String) {
        if selectedNeeds.contains(need) {
            selectedNeeds.removeAll { $0 == need }
        } else {
            selectedNeeds.append(need)
        }
    }
}

// Custom simple FlowLayout for chips
struct FlowLayout<Data: RandomAccessCollection, Content: View, ID: Hashable>: View where Data.Element: Hashable {
    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let content: (Data.Element) -> Content
    
    init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
    }
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(data, id: id) { item in
                    content(item)
                        .padding(4)
                        .alignmentGuide(.leading) { d in
                            if abs(width - d.width) > geo.size.width {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if item == data.last {
                                width = 0
                            } else {
                                width -= d.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if item == data.last {
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    PopUpNeeds()
}

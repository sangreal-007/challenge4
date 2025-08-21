// TabBar.swift
import SwiftUI

struct TabBar: View {
    enum Tab: String, CaseIterable {
        case parent = "Parent"
        case child  = "Child"
        case games  = "Games"
    }

    @Binding var selectedTab: Tab              // Expose the selection via a binding
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = tab
                    }
                }) {
                    Text(tab.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            ZStack {
                                if selectedTab == tab {
                                    Capsule()
                                        .fill(Color("EmotionBarColor"))
                                        .matchedGeometryEffect(id: "TAB_INDICATOR", in: animation)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            Capsule()
                .fill(Color("EmotionBarColorDropShadow"))
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    // Example preview with a State wrapper
    StatefulPreviewWrapper(TabBar.Tab.parent) { selection in
        TabBar(selectedTab: selection)
    }
}

// Helper for previewing a view with a binding
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

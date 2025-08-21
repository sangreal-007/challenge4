//
//  StarDetailView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 21/08/25.
//

import SwiftUI

// Custom shape with a wavy bottom edge
struct Wave: Shape {
    var baselineFraction: CGFloat
    var amplitudeFraction: CGFloat
    var inverted: Bool = false

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baselineY = rect.height * baselineFraction
        let amplitude = rect.height * amplitudeFraction

        // Start at the wave baseline on the left
        path.move(to: CGPoint(x: rect.minX, y: baselineY))

        // Draw the sine wave across the width, flipping it if `inverted` is true
        for x in stride(from: 0, through: rect.width, by: 1) {
            let relativeX = x / rect.width
            let waveValue = sin(relativeX * 2 * .pi)
            let y = baselineY + (inverted ? -waveValue : waveValue) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }

        // Connect to the bottom corners
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

struct StarDetailView: View {
    // Controls whether we show normal activity UI or the empty state.
    @State private var hasActivity: Bool = true
    // Track which tab is selected
    @State private var selectedTab: TabBar.Tab = .parent

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // If there’s an activity, keep the wave backgrounds;
                // otherwise, show a plain “Background” color.
                if hasActivity {
                    Color("LightOrangeBackground")
                        .ignoresSafeArea()
                    Wave(baselineFraction: 0.33, amplitudeFraction: 0.05, inverted: true)
                        .fill(Color("DarkOrangeBackground"))
                        .ignoresSafeArea()
                } else {
                    Color("Background")
                        .ignoresSafeArea()
                }
            }
            // Top overlay: stays pinned to the top
            .overlay(alignment: .top) {
                VStack(spacing: 16) {
                    // Back button and date picker remain at the top
                    HStack {
                        BackButton()
                            .padding(.leading, 20)
                        DatePicker()
                            .padding(.leading, 2)
                        Spacer()
                    }

                    // Show the tab bar and cards only when there's activity
                    if hasActivity {
                        TabBar(selectedTab: $selectedTab)
                            .padding(.top, -2)

                        // Cards vary based on the selected tab
                        VStack(spacing: 12) {
                            switch selectedTab {
                            case .parent:
                                Cards(state: .feeling)
                                Cards(state: .why)
                                Cards(state: .need)
                            case .child:
                                Cards(state: .feeling)
                                Cards(state: .need)
                            case .games:
                                Cards(state: .games)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            // Bottom overlay: used only when there is no activity
            .overlay(alignment: .bottom) {
                if !hasActivity {
                    NoActivityCard()
                        .padding(.bottom, 100)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}
#Preview {
    StarDetailView()
}

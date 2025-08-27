//
//  ProgressBarView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct ProgressBarView: View {
    var daysCount: Int
    var daysTotal: Int
    @State private var navigateToCalendar = false
    
    var body: some View {
        Button(action: {
            navigateToCalendar = true
        }) {
            ZStack {
                Image("ProgressBar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 127, height: 65)
                
                HStack(spacing: 0) {
                    Text("\(daysCount)")
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("/\(daysTotal)")
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.3))
                }
                .padding(.leading, 30)
                .padding(.bottom, 7)
            }
        }
        .buttonStyle(BounceButtonStyle())
        .navigationDestination(isPresented: $navigateToCalendar) {
            CalendarView()
        }
    }
}


#Preview {
    ProgressBarView(daysCount: 0, daysTotal: 31)
}

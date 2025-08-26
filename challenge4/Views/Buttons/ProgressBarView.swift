//
//  ProgressBarView.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var navigateToCalendar = false
    @State private var daysCount : Int = 7
    @State private var daysTotal: Int = 30
    
    var body: some View {
        Button(action: {
            navigateToCalendar = true
        }) {
            ZStack{
                Image("ProgressBar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 177, height: 65)
                
                HStack(spacing: 0) {
                    Text ("\(daysCount)")
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("/\(daysTotal)")
                        .font(.title)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(
                            .white
                                .opacity(0.3))
                    
                }.padding(.leading, 40)
                    .padding(.bottom, 7)
            }
        }.buttonStyle(BounceButtonStyle())
            .navigationDestination(isPresented: $navigateToCalendar) {
                CalendarView()
            }
    }
}


#Preview {
    ProgressBarView()
}

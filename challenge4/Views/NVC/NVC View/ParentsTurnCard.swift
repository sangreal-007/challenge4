//
//  ParentsTurnCard.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 25/08/25.
//

import SwiftUI

struct ParentsTurnCard: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 31)
                .frame(width: 150, height: 40)
                .foregroundColor(Color.emotionBar)
            
            Text("Parent's Turn")
                .font(.callout)
                .fontDesign(.rounded)
                .foregroundColor(.white)
                
        }
    }
}

#Preview {
    ParentsTurnCard()
}

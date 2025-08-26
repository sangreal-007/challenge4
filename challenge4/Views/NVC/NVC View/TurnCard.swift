//
//  TurnCard.swift
//  challenge4
//
//  Created by Dhafindra Razaqa Stefano on 26/08/25.
//

import SwiftUI

struct TurnCard: View {
    let isParent: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 31)
                .frame(width: isParent ? 150 : 120, height: 40)
                .foregroundColor(Color.emotionBar)
            
            Text(isParent ? "Parent's Turn" : "Child's Turn")
                .font(.callout)
                .fontDesign(.rounded)
                .foregroundColor(.white)
                
        }
    }
}

#Preview {
    TurnCard(isParent: true)
}

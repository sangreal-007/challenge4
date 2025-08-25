//
//  PopUpDelete.swift
//  challenge4
//
//  Created by Levana on 25/08/25.
//

import SwiftUI

struct PopUpDelete: View {
    @Binding var isPresented: Bool
    var onDelete: (() -> Void)? = nil
    
    var body: some View {
        if isPresented {
            ZStack {

                // Background dimmed
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Title
                    Text("Do you want to delete the recording?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    Divider().background(Color.white.opacity(0.3))
                    
                    HStack(spacing: 35){
                        HStack{
                            // Cancel Button
                            Button(action: {
                                withAnimation { isPresented = false }
                            }) {
                                Text("Cancel")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }
                        // Delete Button
                        Button(action: {
                            withAnimation { isPresented = false }
                            onDelete?()
                        }) {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .font(.title2)
                                Text("Delete")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 20)
                            .background(Color.trash)
                            .clipShape(Capsule())
                            .shadow(color: .trashDropShadow.opacity(1), radius: 0, x: 0, y: 6)
                        }
                    }
                    .padding(.bottom, 25)
                }
                .frame(width: 320)

                .background(Color.popUpBackground)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            .transition(.opacity)
        }
    }
}

#Preview {
    StatefulPreviewWrapper(true) { isPresented in
        ZStack {
            Color.gray.ignoresSafeArea()
            PopUpDelete(isPresented: isPresented) {
                print("Deleted in preview!")
            }
        }
    }
}

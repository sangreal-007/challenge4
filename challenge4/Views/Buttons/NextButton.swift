import SwiftUI

// MARK: - Next Button
struct NextButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.buttonBlue)
                    .frame(width: 69, height: 69)
                    .shadow(color: Color.buttonBlueDropShadow, radius: 0, x: 0, y: 8)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(BounceButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        NextButton(action: {
            
        })
    }
    .previewLayout(.sizeThatFits)
}

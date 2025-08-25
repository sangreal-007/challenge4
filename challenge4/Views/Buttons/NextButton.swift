import SwiftUI

// MARK: - Next Button
struct NextButton: View {
    let isLast: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color(hex: 0x3E3BC8))
                    .frame(width: 69, height: 69)
                    .shadow(color: Color(hex: 0x2B28B2), radius: 0, x: 0, y: 8)
                
                Image(systemName: isLast ? "checkmark" : "chevron.right")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

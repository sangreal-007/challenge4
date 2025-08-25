
import SwiftUI

// MARK: - Permission Buttons
struct PermissionButtons: View {
    let onAllow: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Allow Microphone button
            Button(action: onAllow) {
                HStack(spacing: 12) {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text("Allow Microphone")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                .frame(width: 272, height: 64)
                .background(Color(hex: 0x3E3BC8))
                .cornerRadius(57)
                .shadow(color: Color(hex: 0x2B28B2), radius: 0, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 57)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .shadow(color: Color.white.opacity(0.25), radius: 0, x: 1, y: 5)
                        .blendMode(.overlay)
                )
            }
            .buttonStyle(ScaleButtonStyle())
            
            // Later in Settings button
            Button(action: onAllow) { // Same action for now
                Text("Later in Settings")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(Color(hex: 0x7672FF))
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}

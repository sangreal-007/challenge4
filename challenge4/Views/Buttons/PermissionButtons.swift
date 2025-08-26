
import SwiftUI

// MARK: - Permission Buttons
struct PermissionButtons: View {
    let onAllow: () -> Void
    @StateObject private var audioRecorder = AudioRecorderController()
    
    var body: some View {
        VStack(spacing: 20) {
            // Allow Microphone button
            Button(action: {
                audioRecorder.requestPermission {
                    onAllow()
                }
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text("Allow Microphone")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                .frame(width: 272, height: 64)
                .background(.buttonBlue)
                .cornerRadius(57)
                .shadow(color: Color.buttonBlueDropShadow, radius: 0, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 57)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .shadow(color: Color.white.opacity(0.25), radius: 0, x: 1, y: 5)
                        .blendMode(.overlay)
                )
            }
            .buttonStyle(BounceButtonStyle())
            
            // Later in Settings button
            Button(action: {
                // Open Settings app
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }) {
                Text("Later in Settings")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(Color.accentPurple2)
            }
            .buttonStyle(BounceButtonStyle())
        }
    }
}

// MARK: - Preview
#Preview {
    PermissionButtons(onAllow: {
        print("Permission allowed")
    })
    .previewLayout(.sizeThatFits)
}

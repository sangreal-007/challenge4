
import SwiftUI

// MARK: - Colors Extension
extension Color {
    static let accentPurple  = Color(red: 0.46, green: 0.45, blue: 1.00)
    static let accentPurple2 = Color(red: 0.57, green: 0.47, blue: 1.00)
    
    init(hex: UInt, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

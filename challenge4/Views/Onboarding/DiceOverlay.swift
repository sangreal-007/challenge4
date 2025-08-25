import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Dice Overlay
struct DiceCorner: View {
    var body: some View {
#if canImport(UIKit)
        if UIImage(named: "DiceImage") != nil {
            Image("DiceImage")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 148)
                .allowsHitTesting(false)
        } else {
            vectorDice
        }
#else
        vectorDice
#endif
    }
    
    private var vectorDice: some View {
        let base = Color(hexValue: 0x7672FF).opacity(0.10)
        let pip  = Color(hexValue: 0x7672FF).opacity(0.22)
        
        return ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(base)
                .frame(width: 160, height: 148)
            
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(base)
                .frame(width: 125, height: 115)
                .offset(x: 23, y: 21)
            
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(base)
                    .frame(width: 93, height: 93)
                
                let d: CGFloat = 12
                Circle().fill(pip).frame(width: d, height: d).offset(x: -21, y: -21)
                Circle().fill(pip).frame(width: d, height: d).offset(x:  21, y: -21)
                Circle().fill(pip).frame(width: d, height: d)
                Circle().fill(pip).frame(width: d, height: d).offset(x: -21, y:  21)
                Circle().fill(pip).frame(width: d, height: d).offset(x:  21, y:  21)
            }
            .offset(x: 51, y: 44)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Color Extension
extension Color {
    init(hexValue: UInt, alpha: Double = 1.0) {
        let r = Double((hexValue >> 16) & 0xFF) / 255.0
        let g = Double((hexValue >> 8) & 0xFF) / 255.0
        let b = Double(hexValue & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

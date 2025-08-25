import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Model
struct OnboardingPage: Identifiable, Equatable {
    let id = UUID()
    let main: MainIllustration            // single or duo - LARGE main illustration
    let faces: [FacePosition]?            // optional face cluster - SMALL images above text
    let overlay: Overlay?                 // optional per-page overlay (e.g., dice)
    let title: String
    let subtitle: String
    
    enum MainIllustration: Equatable {
        case single(String, width: CGFloat? = nil, height: CGFloat? = nil, offsetX: CGFloat = 0, offsetY: CGFloat = 0)
        case duo(String, String, leftWidth: CGFloat? = nil, leftHeight: CGFloat? = nil, leftOffsetX: CGFloat = 0, leftOffsetY: CGFloat = 0,
                 rightWidth: CGFloat? = nil, rightHeight: CGFloat? = nil, rightOffsetX: CGFloat = 0, rightOffsetY: CGFloat = 0)
    }
    
    struct FacePosition: Equatable {
        let imageName: String
        let width: CGFloat?
        let height: CGFloat?
        let offsetX: CGFloat
        let offsetY: CGFloat
        
        init(_ imageName: String, width: CGFloat? = nil, height: CGFloat? = nil, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
            self.imageName = imageName
            self.width = width
            self.height = height
            self.offsetX = offsetX
            self.offsetY = offsetY
        }
    }
    
    enum Overlay: Equatable { case dice }
    
    // Special button configuration for permission screens
    var hasPermissionButtons: Bool {
        title == "Record precious moments"
    }
}

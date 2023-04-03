import Foundation
import UIKit

struct Feedback {
    
    static func impact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
}

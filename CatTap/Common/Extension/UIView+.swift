import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {  layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    static func animate(duration: TimeInterval, animations: @escaping () -> Void) async -> Void {
        return await withCheckedContinuation { continuation in
            Self.animate(withDuration: duration, animations: animations) { _ in
                continuation.resume(returning: ())
            }
        }
    }
    
}

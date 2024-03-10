import Foundation

/// おもちゃの大きさ
enum ToySize: Int, CaseIterable {
    case small
    case midium
    case large
    
    var cgSize: CGSize {
        switch self {
        case .small: return CGSize(width: 100, height: 100)
        case .midium: return CGSize(width: 150, height: 150)
        case .large: return CGSize(width: 200, height: 200)
        }
    }
}

import Foundation

enum Neko: String {
    case komachi
    case higeyoshi
    
    var resources: [URL] {
        let names = (0...7).map {
            "\(rawValue)_\($0)"
        }
        let photoURLs = names.compactMap {
            Bundle.main.url(forResource: $0, withExtension: "jpg")
        }
        let videoURLs = names.compactMap {
            Bundle.main.url(forResource: $0, withExtension: "MOV")
        }
        return photoURLs + videoURLs
    }
    
    var name: String {
        switch self {
        case .komachi: return "こまち"
        case .higeyoshi: return "ひげよし"
        }
    }
}

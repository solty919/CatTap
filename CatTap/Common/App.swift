import Foundation

final class App {
    
    static let shared = App()
    
    private init() {}
    
    var size: ToySize = .small
    var kind: ToyKind = .bug
    var count = 1
    var isHiddenMode = false
    var intervalTime = 5
    var hiddenTime = 5
    
    private let isNeverShowKey = "isNeverShowKey"
    var isNeverShow: Bool {
        get { UserDefaults.standard.bool(forKey: isNeverShowKey) }
        set { UserDefaults.standard.set(newValue, forKey: isNeverShowKey) }
    }
}

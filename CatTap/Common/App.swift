import Foundation

final class App {
    
    static let shared = App()
    
    var size: ToySize = .small
    var kind: ToyKind = .bug
    var count = 1
    var isHiddenMode = false
    var intervalTime = 5
    var hiddenTime = 5
    
    @Storage("isNeverShowKey", defaultValue: false)
    var isNeverShow: Bool
    
    private init() {}
}

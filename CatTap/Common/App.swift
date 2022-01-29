final class App {
    
    static let shared = App()
    
    var size: ToySize = .small
    var kind: ToyKind = .bug
    var count = 1
    var intervalTime = 5
    var hiddenTime = 5
    
    private init() {}
}

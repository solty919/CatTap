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
    /// 特定のスコア以上を取得して画面を戻った回数
    @Storage("satisfyScore", defaultValue: 0)
    var satisfyScore: Int
    
    @Storage("isAppReview", defaultValue: false)
    var isAppReview: Bool
    
    @Storage("bestScore", defaultValue: 0)
    var bestScore: Int
    
    @Storage("isRecording", defaultValue: false)
    var isRecording: Bool
    
    private init() {}
}

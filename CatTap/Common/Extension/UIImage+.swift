import UIKit
import AVFoundation

extension UIImage {
    
    /// URLから画像を生成。もし失敗したら動画として扱い動画のサムネイルを取得
    /// - Parameter mediaUrl: 画像または動画メディアのURL
    convenience init?(mediaUrl: URL) {
        if let _ = UIImage(contentsOfFile: mediaUrl.path) {
            self.init(contentsOfFile: mediaUrl.path)
        } else {
            self.init(movieUrl: mediaUrl)
        }
    }
    
    /// 動画コンテンツのサムネイルを取得する
    /// - Parameter movieUrl: 動画のURL
    convenience init?(movieUrl: URL) {
        let asset = AVAsset(url: movieUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            self.init(cgImage: thumbnailImage)
        } catch {
            return nil
        }
    }
    
}

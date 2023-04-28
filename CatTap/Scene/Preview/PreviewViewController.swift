import UIKit
import AVFoundation

final class PreviewViewController: UIViewController {

    private let url: URL
    
    required init?(coder: NSCoder) { fatalError() }
    init?(coder: NSCoder, url: URL) {
        self.url = url
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
    }

}

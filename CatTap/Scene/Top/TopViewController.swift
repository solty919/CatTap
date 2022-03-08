import UIKit
import AVKit

final class TopViewController: UIViewController {

    @IBOutlet private weak var handView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handView.layer.cornerRadius = handView.frame.width / 2
        
    }
    
    @IBAction func howToButtonAction(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: "movie", withExtension: "mp4") else {
            return
        }
        let vc = AVPlayerViewController()
        vc.player = AVPlayer(url: url)
        present(vc, animated: true, completion: nil)
    }
    
}

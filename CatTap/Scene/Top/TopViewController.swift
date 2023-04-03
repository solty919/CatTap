import UIKit
import AVKit

final class TopViewController: UIViewController {

    @IBOutlet private weak var handView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handView.layer.cornerRadius = handView.frame.width / 2
    }
    
    func showAppReview() {
        
    }
    
}

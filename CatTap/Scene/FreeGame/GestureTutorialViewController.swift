import UIKit
import Gifu

final class GestureTutorialViewController: UIViewController {

    @IBOutlet private weak var doubleTapImageView: GIFImageView!
    @IBOutlet private weak var twoFingerImageView: GIFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doubleTapImageView.animate(withGIFNamed: "double_tap")
        twoFingerImageView.animate(withGIFNamed: "two_finger")
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

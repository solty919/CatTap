import UIKit
import SpriteKit
import GameplayKit

final class FreeGameViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        performSegue(withIdentifier: "toGestureTutorialViewController", sender: nil)
        
        UIApplication.shared.isIdleTimerDisabled = true
        navigationItem.hidesBackButton = true
        
        if let containerView = self.containerView as? SKView {
            if let scene = SKScene(fileNamed: "BugScene") {
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                containerView.presentScene(scene)
            }
            
            containerView.ignoresSiblingOrder = true
            containerView.allowsTransparency = true
            
            //Debug用
            #if DEBUG
//                containerView.showsFPS = true
//                containerView.showsNodeCount = true
            #endif
        }
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return [.bottom]
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
}

import UIKit
import SpriteKit
import GameplayKit
import StoreKit

final class FreeGameViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !App.shared.isNeverShow {
            performSegue(withIdentifier: "toGestureTutorialViewController", sender: nil)
        }
        
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
            containerView.showsFPS = true
            containerView.showsNodeCount = true
            #endif
        }
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return [.bottom]
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if
            let containerView = containerView as? SKView,
            let scene = containerView.scene as? BugScene
        {
            if 3 < scene.score {
                App.shared.satisfyScore = App.shared.satisfyScore + 1
            }
            
            if 3 < App.shared.satisfyScore {
                if !App.shared.isAppReview {
                    if let scene = view.window?.windowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                    App.shared.isAppReview = true
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

import UIKit
import SpriteKit
import GameplayKit
import StoreKit

final class FreeGameViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    
    private let onEnd: () -> Void
    
    required init?(coder: NSCoder) { fatalError() }
    init?(coder: NSCoder, onEnd: @escaping () -> Void) {
        self.onEnd = onEnd
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !App.shared.isNeverShow {
            performSegue(withIdentifier: "toGestureTutorialViewController", sender: nil)
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
        navigationItem.hidesBackButton = true
        
        if let containerView = self.containerView as? SKView {
            if let scene = SKScene(fileNamed: "ToyScene") {
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
    
    @IBAction private func tapGesture(_ sender: UITapGestureRecognizer) {
        if
            let containerView = containerView as? SKView,
            let scene = containerView.scene as? ToyScene
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
        onEnd()
        navigationController?.popViewController(animated: true)
    }
    
}

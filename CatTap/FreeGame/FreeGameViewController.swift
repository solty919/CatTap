import UIKit
import SpriteKit
import GameplayKit

final class FreeGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        navigationItem.hidesBackButton = true
        
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "BugScene") {
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //Debug用
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return [.bottom]
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
}

import SpriteKit
import GameplayKit
import AVFoundation

final class ToyScene: SKScene {
    
    private lazy var toy = childNode(withName: "toy") as? SKSpriteNode
    private lazy var pointEffect = childNode(withName: "pointEffect") as? SKLabelNode
    private lazy var pointLabel = childNode(withName: "pointLabel") as? SKLabelNode
    private lazy var bestLabel = childNode(withName: "bestLabel") as? SKLabelNode
    private var waveEffect = SKShapeNode(rectOf: CGSize(width: 100, height: 100), cornerRadius: 1000)
    
    var score = 0 { didSet {
        if App.shared.bestScore < score {
            App.shared.bestScore = score
        }
    }}
    private var random: Int { Int.random(in: -10...10) }
    private var player: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .clear
        
        if let bug = toy {
            bug.texture = SKTexture(imageNamed: String(describing: App.shared.kind))
            bug.size = App.shared.size.cgSize
            //透明化設定されている場合のみアニメーション追加
            if App.shared.isHiddenMode {
                bug.run(SKAction.repeatForever(SKAction.sequence([
                    SKAction.wait(forDuration: TimeInterval(App.shared.intervalTime)),
                    SKAction.fadeOut(withDuration: 1),
                    SKAction.wait(forDuration: TimeInterval(App.shared.hiddenTime)),
                    SKAction.fadeIn(withDuration: 1),
                ])))
            }
            
            //個数を設定数だけ増やす
            if 1 < App.shared.count {
                for _ in 1...App.shared.count - 1 {
                    if let clone = bug.copy() as? SKSpriteNode {
                        addChild(clone)
                    }
                }
            }

        }
        
        if let pointEffect = pointEffect {
            pointEffect.alpha = 0
        }
        
        if let pointLabel = pointLabel {
            pointLabel.text = "\(score)P"
        }
        
        if let bestLabel = bestLabel {
            bestLabel.text = "\(App.shared.bestScore)P"
        }
        
        let border = CGRect(x: frame.minX,
                          y: frame.minY,
                          width: frame.width + 160,
                          height: frame.height + 160)
        physicsBody = SKPhysicsBody(edgeLoopFrom: border)
        
        impulse()
        pause()
    }
    
    private func pause() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(abs(random))) {
            self.children
                .filter { $0.name == "toy" }
                .forEach {
                    $0.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    $0.physicsBody?.angularVelocity = 0
                }
            self.pause()
        }
    }
    
    private func impulse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.children
                .filter { $0.name == "toy" }
                .forEach {
                    $0.physicsBody?.applyImpulse(CGVector(dx: self.random * 100, dy: self.random * 100))
                }
            self.impulse()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = toy {
            node.physicsBody?.applyImpulse(CGVector(dx: random * 100, dy: random * 100))
        }
        
        for touche in touches {
            let location = touche.location(in: self)
            if let node = atPoint(location) as? SKSpriteNode {
                if node.name == "toy" {
                    score += 1
                    pointLabel?.text = "\(score)P"
                    bugTouchAction(atPoint: location)
                }
            }
        }
    }
    
    private func bugTouchAction(atPoint position : CGPoint) {
        Feedback.impact()
        // サウンド再生
        if let url = Bundle.main.url(forResource: "papa", withExtension: "mp3") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        // ポイント表示エフェクト
        if let pointEffect = pointEffect?.copy() as? SKLabelNode {
            pointEffect.position = position
            pointEffect.alpha = 1
            pointEffect.run(SKAction.sequence([SKAction.group([SKAction.fadeOut(withDuration: 1),
                                                               SKAction.moveTo(y: position.y + 100, duration: 1)]),
                                               SKAction.removeFromParent()]))
            addChild(pointEffect)
        }
        // 波のエフェクト
        if let waveEffect = waveEffect.copy() as? SKShapeNode {
            waveEffect.lineWidth = 1
            waveEffect.position = position
            waveEffect.run(SKAction.sequence([SKAction.group([SKAction.scale(to: 10, duration: 1),
                                                              SKAction.fadeOut(withDuration: 0.5)]),
                                              SKAction.removeFromParent()]))
            addChild(waveEffect)
        }
    }
    
}

extension ToyScene: SKPhysicsContactDelegate {
    
}
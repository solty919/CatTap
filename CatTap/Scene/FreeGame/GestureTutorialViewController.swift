import UIKit
import Gifu

final class GestureTutorialViewController: UIViewController {

    private var timer: Timer?
    
    @IBOutlet private weak var doubleTapImageView: GIFImageView!
    @IBOutlet private weak var isNeverShow: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        doubleTapAnimate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.doubleTapAnimate()
        }
    }
    
    private func doubleTapAnimate() {
        let duration = 0.05
        let toScale = 0.7
         
        let transformTo = CGAffineTransform(scaleX: toScale,
                                            y: toScale)
        
        Task {
            await UIView.animate(duration: duration) { [weak self] in
                guard let self = self else { return }
                self.doubleTapImageView.transform = transformTo
            }
            await UIView.animate(duration: duration) { [weak self] in
                guard let self = self else { return }
                self.doubleTapImageView.transform = .identity
            }
            await UIView.animate(duration: duration) { [weak self] in
                guard let self = self else { return }
                self.doubleTapImageView.transform = transformTo
            }
            await UIView.animate(duration: duration) { [weak self] in
                guard let self = self else { return }
                self.doubleTapImageView.transform = .identity
            }
        }
    }

    @IBAction private func closeButtonAction(_ sender: UIButton) {
        App.shared.isNeverShow = isNeverShow.isOn
        dismiss(animated: true)
    }
}

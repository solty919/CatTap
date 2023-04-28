import UIKit
import QuickLook
import AVKit

final class TopViewController: UIViewController {

    @IBOutlet private weak var previewButton: UIButton!
    @IBOutlet private weak var handView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    
    private var temporaryUrls = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handView.layer.cornerRadius = handView.frame.width / 2
    }
    
    private func showPreview() {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        previewController.navigationItem.rightBarButtonItems = nil
        present(previewController, animated: true)
    }
    
    @IBAction private func startAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                identifier: "FreeGameViewController",
                creator: { coder in
                    FreeGameViewController(coder: coder, onEnd: {
                        Recording.shared.stop { url in
                            self.temporaryUrls.append(url)
                            self.previewButton.isHidden = false
                        }
                    })
                })
        if App.shared.isRecording {
            Recording.shared.start()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func previewAction(_ sender: UIButton) {
        showPreview()
    }
    
}

extension TopViewController: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return PreviewItem(url: temporaryUrls[index], title: "🐈")
    }
    
}

extension TopViewController: QLPreviewControllerDelegate {
    
    func previewController(_ controller: QLPreviewController, editingModeFor previewItem: QLPreviewItem) -> QLPreviewItemEditingMode {
        .disabled
    }
    
    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        temporaryUrls.forEach {
            try? FileManager.default.removeItem(at: $0)
        }
        temporaryUrls.removeAll()
        previewButton.isHidden = true
    }
    
}

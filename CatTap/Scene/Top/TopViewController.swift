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
        present(previewController, animated: true)
    }
    
    private func showTimelineWithUpload() {
        guard 
            let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "TimeLineViewController") as? TimeLineViewController,
            let url = temporaryUrls.last
        else { return }
        
        show(vc, sender: nil)
        vc.upload(url)
    }
    
    @IBAction private func startAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "FreeGameViewController", creator: { coder in
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
        let alert = UIAlertController(title: "にゃんこムービーをどうするか選んでにゃ🐈", message: "", preferredStyle: .actionSheet)
        alert.addAction(.init(title: "あっぷろーど", style: .default, handler: { _ in
            self.showTimelineWithUpload()
        }))
        alert.addAction(.init(title: "削除", style: .destructive, handler: { _ in
            self.temporaryUrls.forEach { try? FileManager.default.removeItem(at: $0) }
            self.temporaryUrls.removeAll()
            self.previewButton.isHidden = true
        }))
        alert.addAction(.init(title: "キャンセル", style: .cancel))
        
        present(alert, animated: true)
    }
    
}

import UIKit
import QuickLook

final class TesterViewController: UIViewController {
    
    @IBOutlet private weak var komachiHeight: NSLayoutConstraint?
    @IBOutlet private weak var komachiDetailLabel: UILabel!
    @IBOutlet private weak var moreAppearKomachiButton: UIButton!
    @IBOutlet private weak var komachiImageCollectionView: UICollectionView!
    
    @IBOutlet private weak var higeyoshiHeight: NSLayoutConstraint!
    @IBOutlet private weak var higeyoshiDetailLabel: UILabel!
    @IBOutlet private weak var moreAppearHigeyoshiButton: UIButton!
    @IBOutlet private weak var higeyoshiImageCollectionView: UICollectionView!
    
    private var previewState: Neko = .komachi
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)
        
        komachiDetailLabel.text = "\(age()) / キジトラ"
        komachiImageCollectionView.dataSource = self
        komachiImageCollectionView.delegate = self
        komachiImageCollectionView.collectionViewLayout = layout
        komachiImageCollectionView.contentInset = UIEdgeInsets(
            top: 0, left: 16, bottom: 0,right: 16)
        
        higeyoshiDetailLabel.text = "\(age()) / キジシロ"
        higeyoshiImageCollectionView.dataSource = self
        higeyoshiImageCollectionView.delegate = self
        higeyoshiImageCollectionView.collectionViewLayout = layout
        higeyoshiImageCollectionView.contentInset = UIEdgeInsets(
            top: 0, left: 16, bottom: 0,right: 16)
    }
    
    @IBAction private func moreAppearKomachiAction(_ sender: UIButton) {
        guard let constraint = komachiHeight else { return }
        NSLayoutConstraint.deactivate([constraint])
        moreAppearKomachiButton.isHidden = true
    }
    
    @IBAction private func moreAppearHigeyoshiAction(_ sender: UIButton) {
        guard let constraint = higeyoshiHeight else { return }
        NSLayoutConstraint.deactivate([constraint])
        moreAppearHigeyoshiButton.isHidden = true
    }
    private func showPreview(_ index: Int, type: Neko) {
        previewState = type
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        previewController.currentPreviewItemIndex = index
        present(previewController, animated: true)
    }
    
    private func age() -> String {
        let birthdate = DateComponents(year: 2021, month: 7, day: 1)
        let now = Calendar.current.dateComponents([.year, .month, .day],
                                                  from: Date())
        let component = Calendar.current.dateComponents([.year, .month],
                                                        from: birthdate, to: now)
        
        guard
            let year = component.year,
            let month = component.month
        else {
            return ""
        }
        
        return "\(year)歳\(month)ヶ月"
    }
    
}

extension TesterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === komachiImageCollectionView {
            return Neko.komachi.resources.count
        }
        if collectionView === higeyoshiImageCollectionView {
            return Neko.higeyoshi.resources.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        var url: URL?
        if collectionView === komachiImageCollectionView {
            url = Neko.komachi.resources[indexPath.row]
        }
        if collectionView === higeyoshiImageCollectionView {
            url = Neko.higeyoshi.resources[indexPath.row]
        }
        
        if let url = url, let image = UIImage(mediaUrl: url) {
            cell.imageView.image = image
        }
        
        return cell
    }
    
}

extension TesterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === komachiImageCollectionView {
            showPreview(indexPath.row, type: .komachi)
        }
        if collectionView === higeyoshiImageCollectionView {
            showPreview(indexPath.row, type: .higeyoshi)
        }
    }
    
}

extension TesterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 120)
    }
    
}

extension TesterViewController: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        switch previewState {
        case .komachi: return Neko.komachi.resources.count
        case .higeyoshi: return Neko.higeyoshi.resources.count
        }
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        switch previewState {
        case .komachi:
            return Neko.komachi.resources[index] as QLPreviewItem
        case .higeyoshi:
            return Neko.higeyoshi.resources[index] as QLPreviewItem
        }
    }
    
}

extension TesterViewController: QLPreviewControllerDelegate {
    
    func previewController(_ controller: QLPreviewController, editingModeFor previewItem: QLPreviewItem) -> QLPreviewItemEditingMode {
        .disabled
    }
    
}

final class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

import UIKit
import QuickLook

final class TesterViewController: UIViewController {

    @IBOutlet private weak var komachiDetailLabel: UILabel!
    @IBOutlet private weak var komachiImageCollectionView: UICollectionView!
    
    @IBOutlet private weak var higeyoshiDetailLabel: UILabel!
    @IBOutlet private weak var higeyoshiImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        komachiDetailLabel.text = "\(age()) / キジトラ"
        komachiImageCollectionView.dataSource = self
        komachiImageCollectionView.delegate = self
        komachiImageCollectionView.contentInset = UIEdgeInsets(
            top: 0, left: 16, bottom: 0,right: 16)
        
        higeyoshiImageCollectionView.dataSource = self
        higeyoshiImageCollectionView.delegate = self
        higeyoshiImageCollectionView.contentInset = UIEdgeInsets(
            top: 0, left: 16, bottom: 0,right: 16)
        
        higeyoshiDetailLabel.text = "\(age()) / キジシロ"
    }
    
    @objc func previewAction(_ sender: UITapGestureRecognizer) {
        print("タップ", sender)
        
    }
    
    private func showPreview(_ index: Int) {
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
        
        if let url = url {
            cell.imageView.image = UIImage(contentsOfFile: url.path)
        }
        
        cell.addInteraction(UIContextMenuInteraction(delegate: self))
        
        return cell
    }
    
}

extension TesterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showPreview(indexPath.row)
    }
    
}

extension TesterViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil) { elements in
            let action = UIAction(title: "プレビュー",
                                  image: UIImage(systemName: "doc")) { _ in
                print("doc")
            }
            return UIMenu(title: "メニュー", children: [action])
        }
    }
    
}

extension TesterViewController: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        Neko.komachi.resources.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        Neko.komachi.resources[index] as QLPreviewItem
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

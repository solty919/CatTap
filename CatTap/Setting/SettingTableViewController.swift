import UIKit
import SpriteKit

enum ToySize: Int, CaseIterable {
    case small
    case midium
    case large
    
    var cgSize: CGSize {
        switch self {
        case .small: return CGSize(width: 100, height: 100)
        case .midium: return CGSize(width: 150, height: 150)
        case .large: return CGSize(width: 200, height: 200)
        }
    }
}

enum ToyKind: Int, CaseIterable {
    case bug
    case bird
    case fish
}

final class SettingTableViewController: UITableViewController {

    @IBOutlet private weak var toySizeSegmented: UISegmentedControl!
    @IBOutlet private weak var toyKindSegmented: UISegmentedControl!
    @IBOutlet private weak var toyCountLabel: UILabel!
    @IBOutlet private weak var toyCountSlider: UISlider!
    @IBOutlet private weak var toyIntervalTimeLabel: UILabel!
    @IBOutlet private weak var toyIntervalTimeSlider: UISlider!
    @IBOutlet private weak var toyHiddenTimeLabel: UILabel!
    @IBOutlet private weak var toyHiddenTimeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toySizeSegmented.selectedSegmentIndex = ToySize.allCases.firstIndex(of: App.shared.size) ?? 0
        toyKindSegmented.selectedSegmentIndex = ToyKind.allCases.firstIndex(of: App.shared.kind) ?? 0
        
        toyCountLabel.text = String(App.shared.count)
        toyCountSlider.value = Float(App.shared.count)
        
        toyIntervalTimeLabel.text = String(App.shared.intervalTime)
        toyIntervalTimeSlider.value = Float(App.shared.intervalTime)
        
        toyHiddenTimeLabel.text = String(App.shared.hiddenTime)
        toyHiddenTimeSlider.value = Float(App.shared.hiddenTime)
    }

    @IBAction func toySizeChangeAction(_ sender: UISegmentedControl) {
        let size = ToySize(rawValue: sender.selectedSegmentIndex) ?? .small
        App.shared.size = size
    }
    
    @IBAction func toyKindChangeAction(_ sender: UISegmentedControl) {
        let kind = ToyKind(rawValue: sender.selectedSegmentIndex) ?? .bug
        App.shared.kind = kind
    }
    
    @IBAction func toyCountChangeAction(_ sender: UISlider) {
        toyCountLabel.text = String(Int(sender.value.rounded()))
        App.shared.count = Int(sender.value.rounded())
    }
    
    @IBAction func toyIntervalTimeChangeAction(_ sender: UISlider) {
        toyIntervalTimeLabel.text = String(Int(sender.value.rounded()))
        App.shared.intervalTime = Int(sender.value.rounded())
    }
    
    @IBAction func toyHiddenTimeChangeAction(_ sender: UISlider) {
        toyHiddenTimeLabel.text = String(Int(sender.value.rounded()))
        App.shared.hiddenTime = Int(sender.value.rounded())
    }
    
}

extension SettingTableViewController {
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = .clear
    }
}

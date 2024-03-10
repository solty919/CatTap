import UIKit
import SpriteKit
import AVFoundation

final class SettingTableViewController: UITableViewController {
    @IBOutlet private weak var recordingSwitch: UISwitch!
    
    @IBOutlet private weak var sizeSegmented: UISegmentedControl!
    @IBOutlet private weak var kindSegmented: UISegmentedControl!
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var countSlider: UISlider!
    
    @IBOutlet private weak var isHiddenSwitch: UISwitch!

    @IBOutlet private weak var intervalTimeContentView: UIView!
    @IBOutlet private weak var intervalTimeLabel: UILabel!
    @IBOutlet private weak var intervalTimeSlider: UISlider!

    @IBOutlet private weak var hiddenTimeContentView: UIView!
    @IBOutlet private weak var hiddenTimeLabel: UILabel!
    @IBOutlet private weak var hiddenTimeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSwitch.isOn = App.shared.isRecording
        
        sizeSegmented.selectedSegmentIndex = ToySize.allCases.firstIndex(of: App.shared.size) ?? 0
        kindSegmented.selectedSegmentIndex = ToyKind.allCases.firstIndex(of: App.shared.kind) ?? 0
        
        countLabel.text = String(App.shared.count)
        countSlider.value = Float(App.shared.count)
        
        isHiddenSwitch.isOn = App.shared.isHiddenMode
        
        intervalTimeLabel.text = String(App.shared.intervalTime)
        intervalTimeSlider.value = Float(App.shared.intervalTime)
        
        hiddenTimeLabel.text = String(App.shared.hiddenTime)
        hiddenTimeSlider.value = Float(App.shared.hiddenTime)
        
        hiddenMode(App.shared.isHiddenMode)
    }

    @IBAction private func toySizeChangeAction(_ sender: UISegmentedControl) {
        let size = ToySize(rawValue: sender.selectedSegmentIndex) ?? .small
        App.shared.size = size
    }
    
    @IBAction private func toyKindChangeAction(_ sender: UISegmentedControl) {
        let kind = ToyKind(rawValue: sender.selectedSegmentIndex) ?? .bug
        App.shared.kind = kind
    }
    
    @IBAction private func toyCountChangeAction(_ sender: UISlider) {
        countLabel.text = String(Int(sender.value.rounded()))
        App.shared.count = Int(sender.value.rounded())
    }
    
    @IBAction private func isHiddenSwitchAction(_ sender: UISwitch) {
        App.shared.isHiddenMode = sender.isOn
        hiddenMode(sender.isOn)
    }
    
    @IBAction private func toyIntervalTimeChangeAction(_ sender: UISlider) {
        intervalTimeLabel.text = String(Int(sender.value.rounded()))
        App.shared.intervalTime = Int(sender.value.rounded())
    }
    
    @IBAction private func toyHiddenTimeChangeAction(_ sender: UISlider) {
        hiddenTimeLabel.text = String(Int(sender.value.rounded()))
        App.shared.hiddenTime = Int(sender.value.rounded())
    }
    
    private func hiddenMode(_ isHidden: Bool) {
        intervalTimeContentView.alpha = isHidden ? 1 : 0.5
        hiddenTimeContentView.alpha = isHidden ? 1 : 0.5
        intervalTimeSlider.isEnabled = isHidden
        hiddenTimeSlider.isEnabled = isHidden
        tableView.reloadData()
    }
    
    @IBAction private func recordingSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            let auth = AVCaptureDevice.authorizationStatus(for: .video)
            switch auth {
            case .notDetermined: requestVideo(sender)
            case .authorized: App.shared.isRecording = sender.isOn
            case .denied, .restricted: sender.isOn = false
            @unknown default: break
            }
            
        } else {
            App.shared.isRecording = sender.isOn
        }
    }
    
    private func requestVideo(_ sender: UISwitch) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            Task { @MainActor in
                if granted {
                    App.shared.isRecording = sender.isOn
                } else {
                    sender.isOn = false
                }
            }
        }
    }
    
}

extension SettingTableViewController {
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

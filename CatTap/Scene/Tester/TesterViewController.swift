import UIKit

final class TesterViewController: UIViewController {

    @IBOutlet private weak var komachiDetailLabel: UILabel!
    @IBOutlet private weak var higeyoshiDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        komachiDetailLabel.text = "\(age()) / キジトラ"
        higeyoshiDetailLabel.text = "\(age()) / キジシロ"
    }
    
    private func age() -> String {
        let birthdate = DateComponents(year: 2021, month: 7, day: 1)
        let now = Calendar.current.dateComponents([.year, .month, .day],
                                                  from: Date())
        let component = Calendar.current.dateComponents([.year, .month], from: birthdate, to: now)
        
        guard
            let year = component.year,
            let month = component.month
        else {
            return ""
        }
        
        return "\(year)歳\(month)ヶ月"
    }
    
}

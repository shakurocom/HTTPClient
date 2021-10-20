import Foundation
import UIKit

class ExampleCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!

    func setup(title: String) {
        titleLabel.text = title
    }

}

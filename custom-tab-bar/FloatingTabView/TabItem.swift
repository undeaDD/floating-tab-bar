import UIKit

struct TabItem {
    let label: String
    let image: UIImage

    let isModal: Bool
    let vc: String
}

protocol TabItemProvider {
    var data: [TabItem]? { get }
}

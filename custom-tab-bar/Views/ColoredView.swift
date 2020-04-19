import UIKit

class ColoredView: UIViewController, TabItemProvider {
    var data: [TabItem]? = [
        TabItem(label: "Left View"  , image: UIImage(), isModal: false, vc: "ColoredView"),
        TabItem(label: "Middle View", image: UIImage(), isModal: true , vc: "ColoredView"),
        TabItem(label: "Right View" , image: UIImage(), isModal: false, vc: "ColoredView")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Colored View \(Int.random(in: 0...1000))"
        view.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
}

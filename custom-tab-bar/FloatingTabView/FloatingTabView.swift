import UIKit
import FloatingPanel

class FloatingTabView : UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    private var modalView: FloatingPanelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set TabItemProvider landingView here
        (children.first as? UINavigationController)?.setViewControllers([ColoredView()], animated: false)
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func setView(_ row: Int) {
        guard let navController = children.first as? UINavigationController,
              let currentVC = navController.topViewController as? TabItemProvider,
              let newItem = currentVC.data?[row]
        else { fatalError() }
        
        // todo: convert newItem.vc String to UIViewController
        // via storyboard init / uiviewcontroller extension ...
        let vc = ColoredView()
        
        if newItem.isModal {
            modalView = FloatingPanelController()
            modalView?.surfaceView.backgroundColor = .clear
            modalView?.surfaceView.cornerRadius = 16.0
            modalView?.isRemovalInteractionEnabled = true
            modalView?.surfaceView.contentInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
            modalView?.backdropView.dismissalTapGestureRecognizer.isEnabled = true
            modalView?.set(contentViewController: vc)
            modalView?.addPanel(toParent: self)
        } else {
            navController.setViewControllers([vc], animated: false)
        }
    }
}

extension FloatingTabView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // todo: design fancy TabBarItem
        // get data from current TabBarProvider -> [indexPath.row] -> get label and image -> profit
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabBarCell", for: indexPath)
        cell.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setView(indexPath.row)
    }
}

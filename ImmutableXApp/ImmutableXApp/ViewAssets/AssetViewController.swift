import UIKit
import ImmutableXCore
import ImmutableXWalletSDK

class AssetViewController: UIViewController {

    var overviews = [overview]()
    
    lazy var titleView: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 28, text: "My Assets", bold: true)
        return text
    }()
    
    lazy var upcomingCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(AssetCell.self, forCellWithReuseIdentifier: "assetCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    @objc func dismissVC() {
      self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
        overviews = [
            overview(image: "Astronaut", title: "Terry", description: "0.001 Ξ"),
            overview(image: "Cat", title: "Nine", description: "0.002 Ξ"),
            overview(image: "Dog", title: "Rocky", description: "0.0005 Ξ"),
            overview(image: "Chicken", title: "KFC", description: "0.002 Ξ"),
            overview(image: "Monkey", title: "Coco", description: "0.0024 Ξ"),
            overview(image: "Lion", title: "Simba", description: "0.00001 Ξ"),
        ]
    }
    func setUpView(){
        
        view.addSubview(titleView)
        view.addSubview(upcomingCollectionView)
        
        titleView.anchor(top: view.topAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
        
        upcomingCollectionView.anchor(top: titleView.bottomAnchor, paddingTop: 30, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: 0)
    }
}

extension AssetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return overviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "assetCell",
            for: indexPath) as? AssetCell else { return UICollectionViewCell() }
        let data = overviews[indexPath.item]
        cell.backgroundColor = .clear
        cell.configure(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width / 2) - 5
        let itemHeight = CGFloat(235)//view.bounds.height / 15
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = overviews[indexPath.item]
        let valueToStore = item.image
        UserDefaults.standard.set(valueToStore, forKey: "character")
        self.dismiss(animated: true)

    }
}

struct overview {
    var image: String
    var title: String
    var description: String
}

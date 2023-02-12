import UIKit
import ImmutableXCore
import ImmutableXWalletSDK

class MarketplaceViewController: UIViewController {

    var over: [Overview] = [
        Overview(image: "Char1-1", title: "King", description: "0.001 Ξ"),
        Overview(image: "Char2-1", title: "Tim", description: "0.002 Ξ"),
        Overview(image: "Char3-1", title: "Johnny", description: "0.05 Ξ"),
        Overview(image: "Char4-1", title: "Bill", description: "0.002 Ξ"),
    ]
    
    var stats: [Stats] = [
        Stats(image: "Animal1-1", title: "Current Auctions"),
        Stats(image: "Animal2-1", title: "Newest Additions"),
        Stats(image: "Animal3-1", title: "Hyped Releases"),
        Stats(image: "Animal4-1", title: "Editors' Choice "),
    ]
    
    lazy var titleView: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 28, text: "Marketplace", bold: true)
        return text
    }()
    
    lazy var slider: ForYouMarketPlaceSlider = {
        let slider = ForYouMarketPlaceSlider()
        return slider
    }()
    
    lazy var exploreCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        collectionview.register(StatsCell.self, forCellWithReuseIdentifier: "exploreCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
    }()
    
    lazy var detailedView: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 18, text: "Categories", bold: true)
        return text
    }()
    
    lazy var upcomingCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        collectionview.register(OverviewCell.self, forCellWithReuseIdentifier: "upcomingCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
    }
    func setUpView(){
        
        view.addSubview(titleView)
        view.addSubview(slider)
        view.addSubview(exploreCollectionView)
        view.addSubview(detailedView)
        view.addSubview(upcomingCollectionView)
        
        titleView.anchor(top: view.topAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        slider.anchor(top: titleView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        exploreCollectionView.anchor(top: detailedView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 300)
        
        detailedView.anchor(top: upcomingCollectionView.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 16, width: 0, height: 0)
        
        upcomingCollectionView.anchor(top: slider.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 0, width: 0, height: 200)

    }
}

extension MarketplaceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "exploreCell",
                for: indexPath) as? StatsCell else { return UICollectionViewCell() }
            let data = stats[indexPath.item]
            cell.configure(data: data)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "upcomingCell",
                for: indexPath) as? OverviewCell else { return UICollectionViewCell() }
            let data = over[indexPath.item]
            cell.configure(data: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == exploreCollectionView {
            let itemWidth = collectionView.bounds.width
            let itemHeight = CGFloat(44)//view.bounds.height / 15
            let itemSize = CGSize(width: itemWidth, height: itemHeight)
            return itemSize
        }
        else {
            let itemSize = CGSize(width: 130, height: 150)
            return itemSize
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == exploreCollectionView {
            return 30
        }
        else {
            return 10
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == exploreCollectionView {
            return 20
        }
        else {
            return 20
        }
    }
    
}


struct Overview {
    var image: String
    var title: String
    var description: String
}

struct Stats {
    var image: String
    var title: String
}


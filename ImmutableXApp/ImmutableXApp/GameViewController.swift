import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var scnView: SCNView!
    var scnScene: SCNScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
    }
    
    func setupView() {
      scnView = self.view as! SCNView
    }
    
    func setupScene() {
      scnScene = SCNScene()
      scnView.scene = scnScene
    }

}

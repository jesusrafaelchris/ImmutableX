import UIKit
import SceneKit
import Wink
import Combine
import SpriteKit

class GameViewController: UIViewController {
    
    let facialExpressionDetectorViewController = FacialExpressionDetectorViewController()
    private var cancellables = Set<AnyCancellable>()
    
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var player: SCNNode!
    var spawnTime: TimeInterval = 0
    var game = GameHelper.sharedInstance
    var flipped: Float = -1
    var blocks = [SCNNode]()
    var velocity = 1
    var gapsize = 10
    var maxHeight = 10
    let kGroundSpeed: CGFloat = 150.0
    var lastBottomBoxMaxX: CGFloat?
    var lastTopBoxMaxX: CGFloat?
    var shouldKeepMoving = true
    var didEndGame = false
    
    lazy var scnView: SCNView = {
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.delegate = self
        return sceneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        addLight()
        setupHUD()
        spawnCharacter()
        //addFacialExpressionDetector()
        //subscribeToFacialExpressionChanges()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipGravity)))
    }
    
    @objc func flipGravity() {
        jumpBox(box: player)
    }
    
    // MARK: Setup methods
    
//    private func addFacialExpressionDetector() {
//        addChild(facialExpressionDetectorViewController)
//        view.addSubview(facialExpressionDetectorViewController.view)
//        facialExpressionDetectorViewController.didMove(toParent: self)
//        facialExpressionDetectorViewController.view.isHidden = true
//    }
//    
//    private func subscribeToFacialExpressionChanges() {
//        facialExpressionDetectorViewController.facialExpressionPublisher.sink(receiveValue: { [weak self]  expressions in
//            guard let strongSelf = self else {return}
//            let blink1 = [FacialExpression(rawValue: "eyeBlinkLeft"), FacialExpression(rawValue: "eyeBlinkRight")]
//            let blink2 = [FacialExpression(rawValue: "eyeBlinkLeft"), FacialExpression(rawValue: "eyeBlinkRight")]
//            DispatchQueue.main.async {
//                if expressions ==  blink1 || expressions == blink2 {
//                    strongSelf.flipped = -1 * strongSelf.flipped
//                    strongSelf.scnScene.physicsWorld.gravity = SCNVector3Make(0, strongSelf.flipped * 50, 0)
//                }
//            }
//        }).store(in: &cancellables)
//    }
    
    func setupView() {
        view.addSubview(scnView)
        NSLayoutConstraint.activate([
            scnView.topAnchor.constraint(equalTo: view.topAnchor),
            scnView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scnView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scnView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        scnView.isPlaying = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnScene.background.contents = "GeometryFighter.scnassets/Textures/Gradient.png"
        scnScene.physicsWorld.gravity = SCNVector3Make(0, -100, 0)
        scnView.scene = scnScene
    }
    
    func addLight() {
        let light = SCNLight()
        light.type = .omni
        light.color = UIColor.white

        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 0, y: 6, z: 25)
        scnScene.rootNode.addChildNode(lightNode)

    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 5, y: 6, z: 30)
        //cameraNode.eulerAngles.y = -(.pi / 6)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnCharacter() {
        var geometry: SCNGeometry
        geometry = SCNBox(width: 2, height: 3, length: 3, chamferRadius: 0)
        geometry.materials.first?.diffuse.contents = UIColor.white
        player = SCNNode(geometry: geometry)
        player.name = "player"
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        player.physicsBody = physicsBody
        player.position = SCNVector3(x: 0, y: 4, z: 0)
        let character = UserDefaults.standard.string(forKey: "character")
        print(character)
        if character == "" {
            player.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/BLM_Space.png"
        }
        else {
            let charactersafe = character!
            player.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/\(charactersafe).png"
        }

        scnScene.rootNode.addChildNode(player)
    }
    
    func cleanScene() {
        for node in scnScene.rootNode.childNodes {
            if node.presentation.position.x < -2 {
                node.removeFromParentNode()
            }
        }
    }
    
    func jumpBox(box: SCNNode) {
        flipped = -1 * flipped
        scnScene.physicsWorld.gravity = SCNVector3Make(0, flipped * 100, 0)
        // moveCharacterInXaxis(box: box, sign: 1)
    }
    
    func setupHUD() {
        game.hudNode.position = SCNVector3(x: 0.0, y: 12.0, z: 0.0)
        scnScene.rootNode.addChildNode(game.hudNode)
    }
    
    func spawnTerrainBox(
        with boxGeometry: SCNBox,
        colour: UIColor) -> SCNNode {
            //create geometry
            var geometry = SCNGeometry()
            geometry = boxGeometry
            geometry.materials.first?.diffuse.contents = UIColor.white//"GeometryFighter.scnassets/Textures/wall.png"
            
            //create node
            let geometryNode = SCNNode(geometry: geometry)
            geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            return geometryNode
        }
    
    func nextBlockSize() -> SCNBox {
        let width = [4,5,6,7,8,9,10].randomElement()
        return SCNBox(width: CGFloat(width ?? 1), height: 1.0, length: 2.0, chamferRadius: 0.0)
    }
    
    func spawnBottomBox() -> SCNNode {
        //bottom
        let width = [5,6,7,8,9,10].randomElement()
        let bottomSize = SCNBox(width: CGFloat(width ?? 1), height: 1.0, length: 5.0, chamferRadius: 0.0)
        let bottomColour = UIColor.white
        let bottomBox = spawnTerrainBox(
            with: bottomSize,
            colour: bottomColour)
        if let lastTopBoxMaxX = lastTopBoxMaxX {
            bottomBox.position = SCNVector3(x: Float(bottomBox.width) + Float(lastTopBoxMaxX / 2), y: 0, z: 0.0)
            lastBottomBoxMaxX = CGFloat(bottomBox.width) + lastTopBoxMaxX
        }
        else {
            bottomBox.position = SCNVector3(x: 0, y: 0, z: 0.0)
            lastBottomBoxMaxX = CGFloat(bottomBox.position.x) + 3
        }
        return bottomBox
    }
    func spawnTopBox() -> SCNNode {
        //top
        let width = [5,6,7,8,9,10].randomElement()
        let topSize = SCNBox(width: CGFloat(width ?? 1), height: 1.0, length: 5.0, chamferRadius: 0.0)
        let topColour = UIColor.white
        let topBox = spawnTerrainBox(
            with: topSize,
            colour: topColour)
        if let lastBottomBoxMaxX = lastBottomBoxMaxX {
            topBox.position = SCNVector3(x: Float(topBox.width) + Float(lastBottomBoxMaxX / 2), y: 8, z: 0.0)
            lastTopBoxMaxX = CGFloat(topBox.width) + lastBottomBoxMaxX
        }
        else {
            topBox.position = SCNVector3(x: 0, y: 8, z: 0.0)
            lastTopBoxMaxX = topBox.width + 2
        }
        return topBox
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: scnView)
//        let hitResults = scnView.hitTest(location, options: nil)
//        if let result = hitResults.first {
//            jumpBox(box: result.node)
//        }
//    }
    
    func spawnTerrain() {
        let bottom = spawnBottomBox()
        let top = spawnTopBox()
        
        moveInXaxis(box: bottom, sign: -1)
        moveInXaxis(box: top, sign: -1)
        scnScene.rootNode.addChildNode(bottom)
        scnScene.rootNode.addChildNode(top)
        //blocks.append(terrainBox)
    }
    
    func moveInXaxis(box: SCNNode, sign: Int) {
        let moveAction = SCNAction.moveBy(x: CGFloat(sign * 2), y: 0, z: 0, duration: 0.3)
        box.runAction(moveAction, completionHandler: {
            if true {
                self.moveInXaxis(box: box, sign: sign)
                //box.removeFromParentNode()
            }
        })
    }
    
    func moveCharacterInXaxis(box: SCNNode, sign: Int) {
        self.shouldKeepMoving = false
        let moveAction = SCNAction.moveBy(x: CGFloat(Double(sign) * 2), y: 0, z: 0, duration: 0.1)
        box.runAction(moveAction, completionHandler: {
            self.shouldKeepMoving = false
            if self.shouldKeepMoving {
                self.moveCharacterInXaxis(box: box, sign: sign)
            }
        })
    }
    
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer,
                  updateAtTime time: TimeInterval) {
        
        for node in scnScene.rootNode.childNodes {
            if node.name == "player" {
                if node.presentation.position.y < -15 || node.presentation.position.y > 22  {
                    if didEndGame == false {
                        endGame()
                    }
                }
            }
        }
        
        if time > spawnTime {
            spawnTerrain()
            //remove last block
            //cleanScene()
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
        }
        game.updateHUD()
    }
    
    func endGame() {
        // Show the game over screen
        didEndGame = true
        scnScene.isPaused = true
        DispatchQueue.main.async {
            let gameOverScreen = GameOverViewController()
            //gameOverScreen.score = score
            self.present(gameOverScreen, animated: true, completion: nil)
        }
    }
}

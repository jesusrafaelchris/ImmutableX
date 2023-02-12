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
    var lastCoinBoxMaxX: CGFloat?
    var shouldKeepMoving = true
    var didEndGame = false
    var playerAngle: Float = 0
    var coins = [SCNNode]()
    private var timer: Timer!
    private var seconds = 0
    
    lazy var scnView: SCNView = {
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
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
        setupBarriers()
        spawnCoins()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        //timerLabel.text = String(format: "%.1f", elapsedTime)
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
        
        
        let character = UserDefaults.standard.string(forKey: "character")
        if character == "BLM_Space" {
            addPlanet()
            scnScene.background.contents = "GeometryFighter.scnassets/Textures/SkyGradient.png"
        }
        else {
            scnScene.background.contents = "GeometryFighter.scnassets/Textures/Gradient.png"
        }
        scnScene.physicsWorld.contactDelegate = self
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
        cameraNode.position = SCNVector3(x: 5, y: 6, z: 35)
        //cameraNode.eulerAngles.y = -(.pi / 6)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func addPlanet() {
        var geometry: SCNGeometry
        geometry = SCNPlane(width: 40, height: 30)
        let planet = SCNNode(geometry: geometry)
        planet.name = "planet"
        planet.castsShadow = true
        planet.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/MoonImage.png"
        let physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        planet.physicsBody = physicsBody
        planet.physicsBody?.angularVelocityFactor = SCNVector3(x: 0, y: 0, z: 0)
        planet.position = SCNVector3(x: 20, y: 30, z: -50)
        scnScene.rootNode.addChildNode(planet)
        moveObjectInXaxis(box: planet, sign: -1, amount: 2, speed: 20)
        addClouds()
    }
    
    func generateCloud(position: SCNVector3) -> SCNNode {
        var geometry: SCNGeometry
        geometry = SCNPlane(width: 30, height: 25)
        let planet = SCNNode(geometry: geometry)
        planet.name = "clouds"
        planet.castsShadow = true
        planet.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/Clouds.png"
        let physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        planet.physicsBody = physicsBody
        planet.position = position
        return planet
    }
    
    func addClouds() {
        let cloud1 = generateCloud(position: SCNVector3(x: -5, y: 5, z: -60))
        let cloud2 = generateCloud(position: SCNVector3(x: 25, y: 5, z: -60))
        scnScene.rootNode.addChildNode(cloud1)
        scnScene.rootNode.addChildNode(cloud2)
        moveObjectInXaxis(box: cloud1, sign: -1, amount: 2, speed: 20)
        moveObjectInXaxis(box: cloud2, sign: -1, amount: 2, speed: 20)
    }
    
    // 1
    func createTrail(color: UIColor, geometry: SCNGeometry) ->
      SCNParticleSystem {
      // 2
      let trail = SCNParticleSystem(named: "Trail.scnp", inDirectory: nil)!
      // 3
      trail.particleColor = color
      // 4
      trail.emitterShape = nil
      // 5
      return trail
    }
    
    func spawnCoins() {
        var geometry: SCNGeometry
        geometry = SCNPlane(width: 3, height: 3)
        let coin = SCNNode(geometry: geometry)
        coin.name = "coin"
        coin.castsShadow = true
        coin.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/IMX.png"
        let physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        coin.physicsBody = physicsBody
        let width = [30, 50, 80].randomElement()
        coin.physicsBody?.angularVelocityFactor = SCNVector3(x: 0, y: 0, z: 0)
        coin.position = SCNVector3(x: Float(coin.width) + Float(lastCoinBoxMaxX ?? 0) + Float(width ?? 0), y: 4, z: 0)
        lastCoinBoxMaxX = CGFloat(coin.width) + (lastCoinBoxMaxX ?? 0)
        coins.append(coin)
        coin.physicsBody!.contactTestBitMask = coin.physicsBody!.collisionBitMask
        scnScene.rootNode.addChildNode(coin)
        moveInXaxis(box: coin, sign: -1)
    }
    
    func setupBarriers() {
        let backBarrier = spawnTerrainBox(with: SCNBox(width: 20, height: 20, length: 1, chamferRadius: 0), colour: .clear)
        backBarrier.position = SCNVector3(x: 0, y: 0, z: -3.2)
        
        let frontBarrier = spawnTerrainBox(with: SCNBox(width: 20, height: 20, length: 1, chamferRadius: 0), colour: .clear)
        frontBarrier.position = SCNVector3(x: 0, y: 0, z: 3.2)
        
        scnScene.rootNode.addChildNode(backBarrier)
        scnScene.rootNode.addChildNode(frontBarrier)
    }
    
    func spawnCharacter() {
        var geometry: SCNGeometry
        geometry = SCNPlane(width: 3, height: 3)
        //geometry.materials.first?.diffuse.contents = returnMaterialColour()
        player = SCNNode(geometry: geometry)
        player.name = "player"
        player.castsShadow = false
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        player.physicsBody = physicsBody
        //player.physicsBody?.angularVelocity = SCNVector4(0, 0, 0, 0)
        player.physicsBody?.angularVelocityFactor = SCNVector3(x: 0, y: 0, z: 0)
        player.position = SCNVector3(x: 0, y: 4, z: 0)
        let character = UserDefaults.standard.string(forKey: "character")
        if character == "" {
            player.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/BLM_Space.png"
        }
        else {
            let charactersafe = character!
            player.geometry?.materials.first?.diffuse.contents =  "GeometryFighter.scnassets/Textures/\(charactersafe).png"
        }
        let trailEmitter = createTrail(color: .red, geometry: geometry)
        player.addParticleSystem(trailEmitter)
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
        if playerAngle == 0 {
            player.eulerAngles.z = .pi
            playerAngle = .pi
        }
        else if playerAngle == .pi {
            player.eulerAngles.z = 0
            playerAngle = 0
        }
        
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
            geometry.materials.first?.diffuse.contents = colour //"GeometryFighter.scnassets/Textures/wall.png"
            
            //create node
            let geometryNode = SCNNode(geometry: geometry)
            geometryNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
            return geometryNode
        }
    
    func spawnPlane(
        with boxGeometry: SCNPlane,
        colour: UIColor) -> SCNNode {
            //create geometry
            var geometry = SCNGeometry()
            geometry = boxGeometry
            geometry.materials.first?.diffuse.contents = colour //"GeometryFighter.scnassets/Textures/wall.png"
            
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
        let bottomSize = SCNBox(width: CGFloat(width ?? 1), height: 1.0, length: 5.0, chamferRadius: 1.0)
        let bottomColour = UIColor.white
        let bottomBox = spawnTerrainBox(
            with: bottomSize,
            colour: bottomColour)
        let character = UserDefaults.standard.string(forKey: "character")
        if character == "BLM_Space" {
            bottomBox.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/wall.png"
        }
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
        let topSize = SCNBox(width: CGFloat(width ?? 1), height: 1.0, length: 5.0, chamferRadius: 1.0)
        let topColour = UIColor.white
        let topBox = spawnTerrainBox(
            with: topSize,
            colour: topColour)
        let character = UserDefaults.standard.string(forKey: "character")
        if character == "BLM_Space" {
            topBox.geometry?.materials.first?.diffuse.contents = "GeometryFighter.scnassets/Textures/wall.png"
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        jumpBox(box: player)
    }
    
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
    
    func moveObjectInXaxis(box: SCNNode, sign: Int, amount: Int, speed: CGFloat) {
        let moveAction = SCNAction.moveBy(x: CGFloat(sign * amount), y: 0, z: 0, duration: speed)
        box.runAction(moveAction, completionHandler: {
            if true {
                self.moveObjectInXaxis(box: box, sign: sign, amount: amount, speed: speed)
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
            spawnCoins()
            //remove last block
            //cleanScene()
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
        }
        
        game.updateHUD(time: "\(seconds)")
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

extension GameViewController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.name == "player" {
            let contactX = contact.contactPoint.x.rounded()
            let coinAtX = coins.first
            coinAtX?.removeFromParentNode()
            coins.remove(at: 0)
        }
    }
}

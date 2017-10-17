//
//  GameScene.swift
//  JumpIn
//
//  Created by Margaux Dang on 17/10/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    //Variables
    var backgroundNode: SKNode!
    var midgroundNode: SKNode!
    var foregroundNode: SKNode!
    var hudNode: SKNode!
    var player: SKNode!
    var scaleFactor: CGFloat!
    let tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
    var endGamePosition = 0
    let motionManager = CMMotionManager()
    var xAcceleration:CGFloat = 0.0
    var scoreLabel:SKLabelNode!
    var starLabel:SKLabelNode!
    var playersMaxY:Int!
    var gameOver = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Initialization
    override init(size: CGSize) {
        super.init(size: size)
        scaleFactor = self.size.width / 320.0
        
        backgroundNode = createBackgroundNode()
        addChild(backgroundNode)
       
        foregroundNode = SKNode()
        addChild(foregroundNode)
        
        player = createPlayer()
        foregroundNode.addChild(player)
        
        let plateform = createPlateformAtPosition(position: CGPoint(x:160, y:320), ofType: PlateformType.normalBrick)
        foregroundNode.addChild(plateform)
        
        let star = createStarAtPosition(position: CGPoint(x:160,y:220), ofType: StarType.NormalStar)
        foregroundNode.addChild(star)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self

    }
    
    //Manage collision
    func didBegin(_ contact: SKPhysicsContact) {
        var otherNode:SKNode!
        
        if contact.bodyA.node != player{
            otherNode = contact.bodyA.node
        } else {
            otherNode = contact.bodyB.node
        }
        (otherNode as! GameObjectNode).collisionWithPlayer(player: player)
    }

    //Tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.physicsBody?.isDynamic = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
    }
}

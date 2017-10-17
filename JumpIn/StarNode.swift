//
//  StarNode.swift
//  JumpIn
//
//  Created by Margaux Dang on 17/10/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import SpriteKit

enum StarType:Int {
    case NormalStar = 0
    case specialStar = 1
}

class StarNode: GameObjectNode {
    var starType:StarType!
    override func collisionWithPlayer(player: SKNode) -> Bool {
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 20)
        self.removeFromParent()
        return true
    }
}

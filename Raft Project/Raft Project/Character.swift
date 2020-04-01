//
//  Character.swift
//  Raft Project
//
//  Created by Ibrahim Irfan on 2017-05-21.
//  Copyright © 2017 Ibrahim Irfan. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {
    
    // Initialize and configure physics body
    func loadPhysicsBody(text: SKTexture, size: CGSize){
        physicsBody = SKPhysicsBody(texture: text, size: size)
        physicsBody?.categoryBitMask = charCategory
        physicsBody?.contactTestBitMask = ballCategory
        physicsBody?.collisionBitMask = 0

        physicsBody?.affectedByGravity = false
    }
}

//
//  Ball.swift
//  Balls
//
//  Created by Ibrahim Irfan on 2017-04-14.
//  Copyright © 2017 Ibrahim Irfan. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKShapeNode {
    
    var radius: CGFloat!
    var ballSpeed: CGFloat!
    var hit: Bool! = false
    
    override init() {
        super.init()
    }
    
    convenience init(rad: CGFloat, x: CGFloat,y: CGFloat, name: String, speed: CGFloat, label: String) {
        self.init()
        
        self.init(circleOfRadius: rad)
        
        position.x = x
        position.y = y
        self.name = name
        radius = rad
        ballSpeed = speed
        
        
        let ballLabel = SKLabelNode(text: label)
        ballLabel.fontName = "Arial-BoldMT"
        ballLabel.position.y -= 5
        ballLabel.fontColor = UIColor.black
        
        if (name == "10"){
            fillColor = UIColor.orange
            ballLabel.fontSize = 35
        } else {
            fillColor = UIColor.green
            ballLabel.fontSize = 22
        }
        
        
        addChild(ballLabel)
        loadPhysicsBody()
    }
    
    
    // Initialize and configure physics body
    func loadPhysicsBody(){
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.affectedByGravity = false
        
        physicsBody?.contactTestBitMask = charCategory
        physicsBody?.categoryBitMask = ballCategory
        physicsBody?.collisionBitMask = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

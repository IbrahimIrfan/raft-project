//
//  BallGenerator.swift
//  Raft Project
//
//  Created by Ibrahim Irfan on 2017-05-20.
//  Copyright © 2017 Ibrahim Irfan. All rights reserved.
//

import Foundation
import SpriteKit

class BallGenerator: SKSpriteNode {
    
    var allBalls = [Ball]()
    var ballLabel: String!
    var currentBallId = 0
    var screenSize: CGSize!
    var ballRadius = CGFloat(49.0)
    var ballSpeed = 5.0
    var generationTimer: Timer?
    
    func loadBallsEvery(seconds: TimeInterval, label: String, size: CGSize){
        ballLabel = label
        screenSize = size
        ballRadius += 1
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(generateBall), userInfo: nil, repeats: true)
    }
    
    func generateBall(){
        if (generationTimer?.isValid)!{
            let randPos = arc4random_uniform(101)
            var ball: Ball!
            
            if (currentBallId == 10){
                ball = Ball(rad: (screenSize.width / 2), x: (screenSize.width / 2), y: screenSize.height + ballRadius / 2, name: "\(currentBallId)", speed: 5.0, label: "Peripeteia")
            } else {
                ball = Ball(rad: ballRadius, x: (screenSize.width) * CGFloat(randPos)/100.0, y: screenSize.height + ballRadius / 2, name: "\(currentBallId)", speed: CGFloat(ballSpeed), label: ballLabel)
            }
            
            currentBallId += 1
            ballSpeed += 0.5
            
            allBalls.append(ball)
            
            addChild(ball)
        }
    }
    
    func stop(){
        generationTimer?.invalidate()
    }
    
    func moveBallByName(name: String){
        let ball = childNode(withName: name) as! Ball
        ball.position.y -= ball.ballSpeed
    }
}

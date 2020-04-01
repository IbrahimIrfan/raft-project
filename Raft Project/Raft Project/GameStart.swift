//
//  GameStart.swift
//  Raft Project
//
//  Created by Ibrahim Irfan on 2017-05-11.
//  Copyright © 2017 Ibrahim Irfan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameStart: SKScene, SKPhysicsContactDelegate {
    
    var charSprite: Character!
    var progressNum = CGFloat(0.025)
    var clickedChar = false
    var ballGenerator: BallGenerator!
    var ballLabel: String!
    var screenSize: CGSize!
    var currentBallSpeed: TimeInterval! = 2
    var potLabel: SKLabelNode!
    var potBarProgress: SKShapeNode!
    var potBarFiller: SKShapeNode!
    var flawBarProgress: SKShapeNode!
    var flawBarFiller: SKShapeNode!
    var gameDone: Bool! = false
    var ballTimer: Timer?
    var flawStr: String!
    
    let barHeight = 50.0
    let marginLeft = 20.0
    let marginBottom = 20.0
    let marginBetweenBars = 50.0
    let labelMargin = 10.0
    let cornerRad = CGFloat(5.0)
    var barWidth: Double!
    
    init(size: CGSize, charClicked: String, charClickedFlaw: String) {
        super.init(size: size)
        screenSize = size
        barWidth = Double(screenSize.width - 40.0)
        flawStr = charClickedFlaw
        
        loadPhysicsWorld()
        loadCharacter(name: charClicked)
        loadIntructions()
        loadBars(flaw: charClickedFlaw, size: size)
        
        if (charClicked == "Oedipus"){
            ballLabel = "Truth"
        } else if (charClicked == "Hamlet"){
            ballLabel = "Inaction"
        } else {
            ballLabel = "Doubt"
        }
        loadBallGenerator()
        loadBallTimer()
    }
    
    // Add physics world
    func loadPhysicsWorld(){
        physicsWorld.contactDelegate = self
    }
    
    func loadCharacter(name: String){
        charSprite = Character(imageNamed: name)
        charSprite.position.x = size.width / 2
        charSprite.position.y = size.height / 2
        charSprite.loadPhysicsBody(text: SKTexture(imageNamed: name), size: charSprite.size)
        charSprite.zPosition = 1000
        addChild(charSprite)
    }
    
    func loadIntructions(){
        let instrLabel = SKLabelNode(text: "Avoid your inner conflict")
        instrLabel.fontName = "Courier-Bold"
        instrLabel.position.x = size.width / 2
        instrLabel.position.y = size.height / 2 - (charSprite.size.height / 2 + 20.0)
        instrLabel.zPosition = -1000
        
        addChild(instrLabel)
        
        let when = DispatchTime.now() + 5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            instrLabel.removeFromParent()
        }
    }
    
    func loadBars(flaw: String, size: CGSize){
        
        let flawBar = SKShapeNode(rect: CGRect(x: marginLeft, y: marginBottom, width: barWidth, height: barHeight), cornerRadius: cornerRad)
        flawBar.strokeColor = UIColor.white
        flawBar.lineWidth = 5.0
        addChild(flawBar)
        
        let flawProgressWidth = barWidth - Double((1 - progressNum) * CGFloat(barWidth))
        
        flawBarProgress = SKShapeNode(rect: CGRect(x: marginLeft, y: marginBottom + 2.5, width: flawProgressWidth, height: barHeight - 5.0), cornerRadius: cornerRad)
        flawBarProgress.fillColor = UIColor.red
        flawBarProgress.strokeColor = UIColor.clear
        addChild(flawBarProgress)
        
        flawBarFiller = SKShapeNode(rect: CGRect(x: marginLeft + flawProgressWidth - Double(cornerRad), y: marginBottom + 2.5, width: Double(cornerRad), height: barHeight - 5.0), cornerRadius: 0.0)
        flawBarFiller.fillColor = UIColor.red
        flawBarFiller.strokeColor = UIColor.clear
        addChild(flawBarFiller)

        
        let flawLabel = SKLabelNode(text: "Hamartia")
        flawLabel.fontName = "Courier"
        flawLabel.fontSize = 25
        flawLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        flawLabel.position.x = CGFloat(marginLeft)
        flawLabel.position.y = CGFloat(marginBottom + barHeight + labelMargin)
        addChild(flawLabel)
        
        let potBar = SKShapeNode(rect: CGRect(x: marginLeft, y: marginBottom + barHeight + marginBetweenBars, width: barWidth, height: barHeight), cornerRadius: cornerRad)
        potBar.strokeColor = UIColor.white
        potBar.lineWidth = 5.0
        addChild(potBar)
        
        let potProgressWidth = barWidth - Double(progressNum * CGFloat(barWidth))
        
        potBarProgress = SKShapeNode(rect: CGRect(x: marginLeft, y: marginBottom + barHeight + marginBetweenBars + 2.5, width: potProgressWidth, height: barHeight - 5.0), cornerRadius: cornerRad)
        potBarProgress.fillColor = UIColor.blue
        potBarProgress.strokeColor = UIColor.clear
        addChild(potBarProgress)
        
        potBarFiller = SKShapeNode(rect: CGRect(x: marginLeft + potProgressWidth - Double(cornerRad), y: marginBottom + barHeight + marginBetweenBars + 2.5, width: Double(cornerRad), height: barHeight - 5.0), cornerRadius: 0.0)
        potBarFiller.fillColor = UIColor.blue
        potBarFiller.strokeColor = UIColor.clear
        addChild(potBarFiller)
        
        potLabel = SKLabelNode(text: "Potential")
        potLabel.fontName = "Courier"
        potLabel.fontSize = 25
        potLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        potLabel.position.x = CGFloat(marginLeft)
        potLabel.position.y = CGFloat(marginBottom + 2*barHeight + marginBetweenBars + labelMargin)
        addChild(potLabel)
    }
    
    func updateBars(){
        let flawProgressWidth = barWidth - Double((1 - progressNum) * CGFloat(barWidth))
        
        flawBarProgress = SKShapeNode(rect: CGRect(x: marginLeft, y: marginBottom + 2.5, width: flawProgressWidth, height: barHeight - 5.0), cornerRadius: cornerRad)
        flawBarProgress.fillColor = UIColor.red
        flawBarProgress.strokeColor = UIColor.clear
        addChild(flawBarProgress)
        
        flawBarFiller = SKShapeNode(rect: CGRect(x: marginLeft + flawProgressWidth - Double(cornerRad), y: marginBottom + 2.5, width: Double(cornerRad), height: barHeight - 5.0), cornerRadius: 0.0)
        flawBarFiller.fillColor = UIColor.red
        flawBarFiller.strokeColor = UIColor.clear
        addChild(flawBarFiller)
        
        
        potBarProgress.removeFromParent()
        
        let potProgressWidth = barWidth - Double(progressNum * CGFloat(barWidth))
        
        potBarProgress = SKShapeNode(rect: CGRect(x: marginLeft, y: marginBottom + barHeight + marginBetweenBars + 2.5, width: potProgressWidth, height: barHeight - 5.0), cornerRadius: cornerRad)
        potBarProgress.fillColor = UIColor.blue
        potBarProgress.strokeColor = UIColor.clear
        addChild(potBarProgress)
        
        potBarFiller.removeFromParent()
        
        potBarFiller = SKShapeNode(rect: CGRect(x: marginLeft + potProgressWidth - Double(cornerRad), y: marginBottom + barHeight + marginBetweenBars + 2.5, width: Double(cornerRad), height: barHeight - 5.0), cornerRadius: 0.0)
        potBarFiller.fillColor = UIColor.blue
        potBarFiller.strokeColor = UIColor.clear
        addChild(potBarFiller)
        
        if progressNum >= 0.975{
            gameOver()
        }
    }
    
    func loadBallGenerator(){
        ballGenerator = BallGenerator()
        addChild(ballGenerator)
        ballGenerator.loadBallsEvery(seconds: currentBallSpeed, label: ballLabel, size: screenSize)
        
    }
    
    func loadBallTimer(){
        ballTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fasterBalls), userInfo: nil, repeats: true)
    }
    
    func fasterBalls(){
        if (currentBallSpeed > 0.1){
            ballGenerator.loadBallsEvery(seconds: currentBallSpeed, label: ballLabel, size: screenSize)
            currentBallSpeed = TimeInterval(CGFloat(currentBallSpeed) - 0.1)
        }
    }
    
    func gameOver(){
        gameDone = true
        
        //TODO
        ballGenerator.stop()
        ballTimer?.invalidate()
        
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontColor = UIColor.red
        gameOverLabel.fontName = "Courier-Bold"
        gameOverLabel.fontSize = 50
        gameOverLabel.position.x = size.width / 2
        gameOverLabel.position.y = size.height / 2 + 100
        gameOverLabel.zPosition = 1001
        addChild(gameOverLabel)
        
        let agnLabel = SKLabelNode(text: "(Catharsis)")
        agnLabel.fontColor = UIColor.red
        agnLabel.fontName = "Courier-Bold"
        agnLabel.fontSize = 50
        agnLabel.position.x = size.width / 2
        agnLabel.position.y = size.height / 2
        agnLabel.zPosition = 1001
        addChild(agnLabel)
        
        let when = DispatchTime.now() + 5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            let newScene = GameOver(size: self.size, charSprite: self.charSprite, flaw: self.flawStr)
            newScene.scaleMode = self.scaleMode
            let animation = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(newScene, transition: animation)
        }
        
    }
    
    func flash() -> SKAction {
        let flash = SKAction.sequence([SKAction.hide(), SKAction.wait(forDuration: 0.05), SKAction.unhide(), SKAction.wait(forDuration: 0.05)])
        return SKAction.repeat(flash, count: 2)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let ball = contact.bodyB.node as? Ball{
            if (!ball.hit){
                if ball.name == "10" {
                    progressNum = 0.725
                } else {
                    progressNum += 0.05
                }
                ball.hit = true
                updateBars()
                charSprite.run(flash())
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        for ball in ballGenerator.allBalls {
            if (ball.position.y < potLabel.position.y + 50.0){
                ball.removeFromParent()
                ballGenerator.allBalls.remove(at: ballGenerator.allBalls.index(of:ball)!)
            } else if (!gameDone){
                ballGenerator.moveBallByName(name: ball.name!)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (clickedChar && !gameDone) {
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
                
                if (location.y > potLabel.position.y + charSprite.size.height/2){
                    charSprite.position = location
                }
            
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!gameDone){
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
    
                if (charSprite.contains(location)){
                    clickedChar = true
                } else {
                    clickedChar = false
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  GameOver.swift
//  Raft Project
//
//  Created by Ibrahim Irfan on 2017-05-11.
//  Copyright © 2017 Ibrahim Irfan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    var screenSize: CGSize!
    var characterSprite: SKSpriteNode!
    
    
    init(size: CGSize, charSprite: Character, flaw: String) {
        super.init(size: size)
        screenSize = size
        characterSprite = charSprite
        
        
        loadBulb()
        loadChar()
        loadFlaw(flaw: flaw)
        
        loadLabels()
    
    }
   
    func loadChar(){
        characterSprite.removeFromParent()
        
        characterSprite.position.x = screenSize.width / 2
        characterSprite.position.y = screenSize.height / 2
        
        addChild(characterSprite)
    }
    
    func loadBulb(){
        let bulbSprite = SKSpriteNode(imageNamed: "Bulb")
        bulbSprite.position.x = screenSize.width / 2
        bulbSprite.position.y = screenSize.height / 2 + 100.0
        
        addChild(bulbSprite)
        
    }
    
    
    func loadLabels(){
        let gameOverLabel = SKLabelNode(text: "The End")
        gameOverLabel.fontColor = UIColor.red
        gameOverLabel.fontName = "Courier-Bold"
        gameOverLabel.fontSize = 40
        gameOverLabel.position.x = size.width / 2
        gameOverLabel.position.y = size.height / 2 + 200
        
        addChild(gameOverLabel)
        
        let againLabel = SKLabelNode(text: "Tap to play again")
        againLabel.fontName = "Courier-Bold"
        againLabel.fontSize = 30
        againLabel.position.x = size.width / 2
        againLabel.position.y = 200
        
        addChild(againLabel)
        
        againLabel.run(blink())
        
    }
    
    func loadFlaw(flaw: String){
        let flawLabel = SKLabelNode(text: "Flaw: \(flaw)")
        
        flawLabel.fontName = "Courier"
        flawLabel.fontSize = 18
        flawLabel.position.x = characterSprite.position.x
        flawLabel.position.y = characterSprite.position.y - characterSprite.size.height / 2 - 50.0
        
        
        addChild(flawLabel)
    }
        
    // Blink actions and animation for tap prompt and game over labels
    func blink() -> SKAction {
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.4)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.4)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }
    
    // Restart the game (present new scene)
    func restart() {
        let newScene = GameScene(size: self.size)
        newScene.scaleMode = self.scaleMode
        newScene.anchorPoint = (CGPoint(x: 0.5, y: 0.5))
        self.view?.presentScene(newScene)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       restart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


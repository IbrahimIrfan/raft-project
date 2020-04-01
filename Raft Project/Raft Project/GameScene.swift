//
//  GameScene.swift
//  Raft Project
//
//  Created by Ibrahim Irfan on 2017-05-11.
//  Copyright © 2017 Ibrahim Irfan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {
        loadIntroLabel()
        loadOracle()
        loadCharacterSelect()
    }
    
    func loadIntroLabel(){
        let title = SKLabelNode(text: "Welcome")
        title.fontColor = UIColor.green
        title.fontName = "Courier"
        title.fontSize = 40
        title.position.y = 400
        addChild(title)
        
        let cursor = SKLabelNode(text: "|")
        cursor.fontColor = UIColor.green
        cursor.fontName = "Courier"
        cursor.fontSize = 40
        cursor.position.x = 90
        cursor.position.y = 400
        addChild(cursor)
        cursor.run(blink())
    }
    
    func loadOracle(){
        let oracle = SKSpriteNode(imageNamed: "Oracle")
        oracle.position.y = 200
        addChild(oracle)
    }
    
    func loadCharacterSelect(){
        let charSelectTitle = SKLabelNode(text: "Select your tragic hero")
        charSelectTitle.fontColor = UIColor.green
        charSelectTitle.fontName = "Courier"
        charSelectTitle.fontSize = 30
        charSelectTitle.position.y = 50
        addChild(charSelectTitle)
        
        addCharToScreen(name: "Oedipus", x: -250, y: -150, pot: 98, traits: ["+ Intelligent", "+ Determined", "- Denies Fate"], flaw: "Hubris")
        addCharToScreen(name: "Hamlet", x: 0, y: -150, pot: 99, traits: ["+ Loyal", "+ Intelligent", "- Hubris"], flaw: "Inaction")
        addCharToScreen(name: "Neo", x: 250, y: -165, pot: 97, traits: ["+ Intelligent", "+ The One", "- Confused"], flaw: "Self-Doubt")
    }
    
    func addCharToScreen(name: String, x: CGFloat, y: CGFloat, pot: Int, traits: Array<String>, flaw: String){
        let charSprite = SKSpriteNode(imageNamed: name)
        charSprite.position.x = x
        charSprite.position.y = y
        charSprite.name = name
        addChild(charSprite)
        
        let charLabel = SKLabelNode(text: name)
        charLabel.fontName = "Courier"
        charLabel.fontSize = 20
        charLabel.position.x = x
        charLabel.position.y = -275
        addChild(charLabel)
        
        let potentialLabel = SKLabelNode(text: "Potential: \(pot)")
        potentialLabel.fontColor = UIColor.white
        potentialLabel.fontName = "Courier"
        potentialLabel.fontSize = 20
        potentialLabel.position.x = x
        potentialLabel.position.y = -300
        addChild(potentialLabel)
        
        var spacingCount = 0
        for trait in traits {
            let traitLabel = SKLabelNode(text: trait)
            if (trait[trait.startIndex] == "+"){
                traitLabel.fontColor = UIColor.green
            } else{
                traitLabel.fontColor = UIColor.red
            }
            
            traitLabel.fontName = "Courier"
            traitLabel.fontSize = 20
            traitLabel.position.x = x
            traitLabel.position.y = -350 - CGFloat(spacingCount)
            addChild(traitLabel)
            spacingCount += 25
        }
        
        let tragicFlawLabel = SKLabelNode(text: "Flaw:\n\(flaw)")
        tragicFlawLabel.fontName = "Courier"
        tragicFlawLabel.fontSize = 20
        tragicFlawLabel.position.x = x
        tragicFlawLabel.position.y = -350 - CGFloat(spacingCount + 25)
        addChild(tragicFlawLabel)
        
    }
    
    func charClicked(name: String, flaw: String){
        let newScene = GameStart(size: self.size, charClicked: name, charClickedFlaw: flaw)
        newScene.scaleMode = self.scaleMode
        let animation = SKTransition.fade(withDuration: 1.0)
        self.view?.presentScene(newScene, transition: animation)
    }
    
    // Blink actions and animation for tap prompt and game over labels
    func blink() -> SKAction {
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.4)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.4)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let oed = childNode(withName: "Oedipus")
        let ham = childNode(withName: "Hamlet")
        let neo = childNode(withName: "Neo")
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if (oed?.contains(location))! {
                charClicked(name: "Oedipus", flaw: "Hubris")
            } else if (ham?.contains(location))! {
                charClicked(name: "Hamlet", flaw: "Inaction")
            } else if (neo?.contains(location))! {
                charClicked(name: "Neo", flaw: "Self-Doubt")
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

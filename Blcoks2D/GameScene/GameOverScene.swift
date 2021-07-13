//
//  GameOverScene.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var text = ""
    var presentScene: SKScene?
    
    let cangratulations = SKLabelNode(text: "Congratulations!" )
    let tapToPlay = SKLabelNode(text: "Tap to play")
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        run(SKAction.sequence([
            SKAction.run() { [weak self] in
                guard let self = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                if let presentScene = self.presentScene {
                    self.view?.presentScene(presentScene, transition:reveal)
                } else {
                    self.resetGame()
                    self.view?.presentScene(GameScene(size: self.size), transition: reveal)
                }
            }
            ]))
        
        
    }
    
    
    init(size: CGSize, text: String, presentScene: SKScene?) {
        super.init(size: size)
        self.text = text
        self.backgroundColor = SKColor.black
        self.presentScene = presentScene
        if presentScene != nil {
            self.addChild(cangratulations)
        }
        let gameOver = SKLabelNode(text: text)
        tapToPlay.fontSize = SmallFontSize.size
        cangratulations.fontSize = BigFontSize.size
        gameOver.fontSize = BigFontSize.size
        gameOver.position = CGPoint(x: (size.width/2) - 10, y: size.height/2)
      
        tapToPlay.position = CGPoint(x: size.width/2, y: 50)
        cangratulations.position = CGPoint(x: (size.width/2) - 10, y: gameOver.position.y + 100)
        addChild(gameOver)
        addChild(tapToPlay)
        
        
       
    }
    

    
    private func resetGame() {
//        Constants.level = 1
//        Constants.kTargetColCount = 1
//        Constants.kTargetsRowsCount = 1
        Constants.basicTarget = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

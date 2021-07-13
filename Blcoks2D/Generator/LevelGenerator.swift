//
//  LevelGenerator.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import SpriteKit

public struct WinOver {
    
    public static func gameOver(scene: SKScene) {
        let gameOver = GameOverScene(size: scene.size, text: Constants.gameOverMessage, presentScene: nil)
        let revealGameScene = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
        gameOver.scaleMode = .aspectFill
        scene.view?.presentScene(gameOver, transition: revealGameScene)
    }
    
    public static func youWin (scene: SKScene) {
        
        let gameOver = GameOverScene(size: scene.size, text: Constants.youWin, presentScene: nil)
        let revealGameScene = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
        gameOver.scaleMode = .aspectFill
        scene.view?.presentScene(gameOver, transition: revealGameScene)
        
    }
    
}


public struct NewLevel {
    
    var scene: SKScene
    
    private let columns = { () -> Int in
        var col: Int = 1
        switch Constants.level {
        case 0...9:
            col = 1
        case 10...20:
            col = 2
        case 21...30:
            col = 3
        case 31...40:
            col = 4
        case 41...50:
            col = 5
        default:
            col = 1
        }
        return col
    }()
    
   public func newScene() {
    
        let counter = LevelCounter.defaults
        Constants.level = counter.level + Constants.levelStep
        counter.saveLevel(Constants.level)
      
        let nextLevel = GameScene(size: scene.size)
        let revealGameScene = SKTransition.doorway(withDuration: 0.5)
        nextLevel.scaleMode = .aspectFill
    
        Constants.kTargetsRowsCount = columns
        if Constants.level <= Constants.maxColumnCount {
            Constants.kTargetColCount = Constants.level
        } else {
            Constants.kTargetColCount = Constants.maxColumnCount
        }
        let presenter = GameOverScene(size: scene.size, text: "Level: \(Constants.level)", presentScene: nextLevel)
        scene.view?.presentScene(presenter, transition: revealGameScene)
        
    }
    
    
}

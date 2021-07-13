//
//  GameScene.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //MARK: Properties
 
    var action: ActionsProtocol!
    
    var genWeapon: GenWeapon!
    var genTarget: GenTargers!
    var levelCoordinator: NewLevel!
    
    var gradation: Gradation {
        return Constants.gradation
    }
    
    //MARK: LifeCycle
    
    override func didMove(to view: SKView) {
       
       setBackground()
       basicConfig()
       setUpScene()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        genWeapon.shot()
        
    }
    
    //MARK: Methods
    
    func didShot(shootingArrow: SKSpriteNode, target: SKSpriteNode) {
       
        shootingArrow.name == target.name ? targetHited([shootingArrow, target]) : WinOver.gameOver(scene: self)

    }
    
    
    func targetHited(_ nodes: [SKSpriteNode]) {
        
        action.removeNodes(nodes)
        action.changeScene(with: self) { [weak self] (clear)  in
            clear ?  self?.levelCoordinator.newScene() : self?.genWeapon.returnWeapon()
        }
        
    }
    
    private func setUpScene () {
        
        action = Actions()
        levelCoordinator = NewLevel(scene: self)
        genTarget = GenTargers(scene: self)
        genWeapon = GenWeapon(scene: self, weapon: SKSpriteNode(), gradation: gradation)
        genTarget.setupBlocks()
        genWeapon.returnWeapon()
        
    }
    
    private func basicConfig () {
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
    }
    
    private func setBackground() {
        
        let backgroundImage = SKSpriteNode(imageNamed: "backround")
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.yScale = 2
        backgroundImage.xScale = 2
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
        
    }
    
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if ((firstBody.categoryBitMask & PhysicalCategory.shootingWeapon != 0) && (secondBody.categoryBitMask & PhysicalCategory.target) != 0) {
            if let shootingArrow = firstBody.node as? SKSpriteNode,
                let target = secondBody.node as? SKSpriteNode {
                self.didShot(shootingArrow: shootingArrow, target: target)
            }
        }

    }
    
}

//
//  NodeGenerator.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import SpriteKit

struct GenTargers {
    
    var scene: SKScene!
    
    func makeBlocks() -> SKNode {
        
        let randomInt = Int.random(in: 0...4)
        let blocks = Constants.targets
        let blockName = blocks[randomInt]
        let block = SKSpriteNode(imageNamed: blockName)
        Constants.basicTarget.append(blockName)
        block.name = blocks[randomInt]
        block.physicsBody = SKPhysicsBody(circleOfRadius: PhysicBodySize.size)
        block.physicsBody?.isDynamic = true
        block.physicsBody?.categoryBitMask = PhysicalCategory.target
        block.physicsBody?.contactTestBitMask = PhysicalCategory.shootingWeapon
        block.physicsBody?.collisionBitMask = PhysicalCategory.none
        block.physicsBody?.usesPreciseCollisionDetection = true
        block.size = NodeSize.size
        return block
        
    }
    
    func setupBlocks() {
        
        var baseOrigin: CGPoint
        
        if Constants.level <= 9{
            baseOrigin = CGPoint(x: scene.size.width/2 - (CGFloat(Constants.level) * (NodeSize.size.width / 2)), y: scene.size.height - (NodeSize.size.height * 3))
        } else {
            baseOrigin = CGPoint(x: scene.size.width/2 - (CGFloat(9) * (NodeSize.size.width / 2)), y: scene.size.height - (NodeSize.size.height * 3) )
        }
        
        for row in 1...Constants.kTargetsRowsCount {
            
            let blocksPositionY = baseOrigin.y - ( CGFloat(row) * (NodeSize.size.height) )
            
            var blocksPosition = CGPoint(x: baseOrigin.x + NodeSize.size.width / 2, y: blocksPositionY)
            
            for _ in 1...Constants.kTargetColCount {
                let block = makeBlocks()
                block.position = blocksPosition
                
                scene.addChild(block)
                
                blocksPosition = CGPoint(x: blocksPosition.x + (NodeSize.size.width), y: blocksPositionY)
            }
        }
        
    }
    
}

struct GenWeapon {
    
    let scene: SKScene!
    
    var weapon: SKSpriteNode!
    
    var gradation: Gradation!
    
    mutating func setUpWeaponName() -> (targetName: String, weaponName: String, random: Int) {
        
        updateTargets()
        
        if Constants.basicTarget.count > 0 {
    
            var random: Int!
            
            var nameOfblock: String = ""
            self.gradation = Constants.gradation
            switch gradation {
            case .start?:
                random = Int.random(in: 0..<Constants.basicTarget.count)
                nameOfblock = Constants.basicTarget[random]
            case.two?:
                random = (Int.random(in: 9...Constants.basicTarget.count)) - 1
                nameOfblock = Constants.basicTarget[random]
            case.three?:
                random = (Int.random(in: 18...Constants.basicTarget.count)) - 1
                nameOfblock = Constants.basicTarget[random]
            case.four?:
                random = (Int.random(in: 28...Constants.basicTarget.count)) - 1
                nameOfblock = Constants.basicTarget[random]
            case.five?:
                random = (Int.random(in: 35...Constants.basicTarget.count)) - 1
                nameOfblock = Constants.basicTarget[random]
                
            default:
                break
                
            }
            
            
            return (nameOfblock, getTargetName(from: nameOfblock), random)
            
        } else {
            
            return ("","", 0)
        }
    }
    
    private func updateTargets() {
        var targets: [SKNode] = []
        
        scene.children.forEach { (target) in
            if target.physicsBody?.contactTestBitMask == PhysicalCategory.shootingWeapon {
                targets.append(target)
            }
        }
        let names = targets.map{$0.name!}
        print (scene.children.count,names.count, names)
        Constants.basicTarget = names
    }
    
    private func getTargetName(from: String) -> String {
        
        var name: String {
            switch from {
            case "box01":
                return "ball01"
            case "box02":
                return "ball02"
            case "box03":
                return "ball03"
            case "box04":
                return "ball04"
            case "box05":
                return "ball05"
            default:
                return "ball01"
            }
            
        }
        return name
    }
    
    mutating func returnWeapon() {
        
        let configures = setUpWeaponName()
         if checTheWeapon() {
        weapon = SKSpriteNode(imageNamed: configures.weaponName)
        weapon.position = CGPoint(x: 25, y: NodeSize.size.height * 4)
        weapon.size = CGSize(width: NodeSize.size.width / 2, height: NodeSize.size.height / 2)
        weapon.name = configures.targetName
        
        
        
        weapon.physicsBody = SKPhysicsBody(circleOfRadius: weapon.size.height / 2)
        weapon.physicsBody?.isDynamic = true
        weapon.physicsBody?.categoryBitMask = PhysicalCategory.shootingWeapon
        weapon.physicsBody?.contactTestBitMask = PhysicalCategory.target
        weapon.physicsBody?.collisionBitMask = PhysicalCategory.none
        weapon.physicsBody?.usesPreciseCollisionDetection = true
        weapon.size = NodeSize.size
        
       
        scene.addChild(weapon)
       
        
        let moveAction = SKAction.move(to: CGPoint(x: scene.size.width - 25, y: weapon.position.y),
                                       duration: TimeInterval(2.0))
        let moveReverse = SKAction.move(to: CGPoint(x: 25 , y: weapon.position.y), duration: TimeInterval(2.0))
        
        weapon.run(SKAction.repeatForever(SKAction.sequence([moveAction, moveReverse])))
        } else {
            return
        }
    }
    func checTheWeapon() -> Bool{
        var weapon: SKNode?
        scene.children.forEach { (weap) in
            if weap.physicsBody?.contactTestBitMask == PhysicalCategory.target {
                weapon = weap
            } else {
                weapon = nil
            }
        }
        if weapon == nil {
            return true
        } else {
            return false
        }
    }
    
    func shot() {
        let moveAction = SKAction.move(to: CGPoint(x: weapon.position.x, y: scene.size.height + weapon.size.height), duration: 1.0)
        
        weapon.run(SKAction.sequence([moveAction,  SKAction.run {
            WinOver.gameOver(scene: self.scene)
            }]))
    }
    
}

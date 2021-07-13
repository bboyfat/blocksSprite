//
//  ActionsProtocol.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import SpriteKit

protocol ActionsProtocol {
    func removeNodes(_ nodes: [SKSpriteNode])
    func changeScene(with sizeOf: SKScene, handler: @escaping (Bool) -> ())
}

class Actions : ActionsProtocol {
    
    func removeNodes(_ nodes: [SKSpriteNode]) {
        nodes.forEach { (node) in
            node.removeFromParent()
        }
    }
    
    func changeScene(with sizeOf: SKScene, handler: @escaping (Bool) -> ()) {
        sizeOf.run( SKAction.run({
            if sizeOf.children.count < 2 {
                Constants.basicTarget = []
                handler(true)
            } else {
                handler(false)
            }
        })
        )
    }
}

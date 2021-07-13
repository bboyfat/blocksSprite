//
//  Constants.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import SpriteKit

public struct Constants {
    
    
    static var kTargetsRowsCount = 1
    static var kTargetColCount: Int = {
        if  LevelCounter.defaults.level <= 9{
            return  LevelCounter.defaults.level
        } else {
            return 9
        }
       
    }()
    
    static let maxColumnCount = 9
    
    static var basicTargetsCount: Int = 0
    
    
    static var level = LevelCounter.defaults.level
    static let levelStep = 1
    
    static var basicTarget: [String] = []{
        didSet{
            Constants.basicTargetsCount = Constants.basicTarget.count
        }
    }
    static let targets = ["box01", "box02","box04","box04","box05"]
    static let weapons = ["ball01", "ball02", "ball03", "ball04", "ball05"]
    
    static let gameOverMessage = "Game Over"
    static let nextLevelmessage = "Level: \(Constants.level)!"
    static let youWin = "You Win!"
    
    
    static var gradation: Gradation {
        
        switch self.basicTargetsCount {
        case 0...8:
            return .start
        case 9...17:
            return .two
        case 18...26:
            return .three
        case 27...35:
            return .four
        case 36...44:
            return .five
        default:
            return .start
        }
    }
}

public struct PhysicalCategory {
    
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let shootingWeapon: UInt32 = 0b1
    static let target: UInt32 = 0b10
    
}

public enum  NodeSize {
    static var deviceType: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    static var size: CGSize {
        switch NodeSize.deviceType{
        case .pad:
            return CGSize(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.width / 12)
        case .phone:
            return CGSize(width: UIScreen.main.bounds.size.width / 10, height: UIScreen.main.bounds.size.width / 10)
        default:
            return CGSize(width: UIScreen.main.bounds.size.width / 12, height: UIScreen.main.bounds.size.width / 12)
        }
        
    }
    
}

public enum BigFontSize {
    static var deviceType: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    static var size: CGFloat {
        switch BigFontSize.deviceType{
        case .pad:
            return 86
        case .phone:
            return 36
        default:
            return 86
        }
        
    }
}

public enum SmallFontSize {
    static var deviceType: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    static var size: CGFloat {
        switch SmallFontSize.deviceType{
        case .pad:
            return 43
        case .phone:
            return 20
        default:
            return 43
        }
        
    }
}

public enum PhysicBodySize {
   
    static var size: CGFloat {
        switch SmallFontSize.deviceType{
        case .pad:
            return NodeSize.size.width / 2
        case .phone:
            return NodeSize.size.width / 2.2
        default:
            return NodeSize.size.width / 2
        }
        
    }
}


//
//  LevelCounter.swift
//  Blcoks2D
//
//  Created by Andrey Petrovskiy on 9/21/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


class LevelCounter {
    
    static let defaults = LevelCounter()
    
    let userDefaultes = UserDefaults.standard
    
    var level: Int {
        return userDefaultes.value(forKey: "level") as? Int ?? 1
    }
    
    func saveLevel (_ level: Int) {
        
        userDefaultes.set(level, forKey: "level")
        
    }
    
    private init () {}
    
}

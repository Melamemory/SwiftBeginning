//
//  SnakeHead.swift
//  Snake
//
//  Created by Юлия Ишмурзина on 09.03.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

import SpriteKit

class SnakeHead: SnakeBodyPart {
    
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.Edge | CollisionCategories.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

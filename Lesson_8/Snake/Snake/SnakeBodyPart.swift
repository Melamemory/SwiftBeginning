//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Юлия Ишмурзина on 09.03.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

import SpriteKit

class SnakeBodyPart: SKShapeNode {
    
    init(atPoint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .green
        strokeColor = .green
        
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 3, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.Edge | CollisionCategories.Apple | CollisionCategories.SnakeHead
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

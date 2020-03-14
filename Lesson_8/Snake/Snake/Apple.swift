//
//  Apple.swift
//  Snake
//
//  Created by Юлия Ишмурзина on 09.03.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

import SpriteKit

class  Apple: SKShapeNode {
    
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .red
        strokeColor = .red
        
        lineWidth = 5
        
        self.position = position
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 5, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}

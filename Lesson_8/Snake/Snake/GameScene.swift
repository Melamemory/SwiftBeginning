//
//  GameScene.swift
//  Snake
//
//  Created by Юлия Ишмурзина on 09.03.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let Snake: UInt32      = 0x1 << 0
    static let SnakeHead: UInt32  = 0x1 << 1
    static let Apple: UInt32      = 0x1 << 2
    static let Edge: UInt32       = 0x1 << 3
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = .darkGray
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        
        physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.Edge | CollisionCategories.Snake
        
        let couterClockwiseButton = SKShapeNode()
        couterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        couterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30,
                                                 y: view.scene!.frame.minY + 30)
        
        couterClockwiseButton.fillColor = .lightGray
        couterClockwiseButton.strokeColor = .lightGray
        couterClockwiseButton.lineWidth = 10
        
        couterClockwiseButton.name = "couterClockwiseButton"
        
        addChild(couterClockwiseButton)
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80,
                                           y: view.scene!.frame.minY + 30)
        
        clockwiseButton.fillColor = .lightGray
        clockwiseButton.strokeColor = .lightGray
        clockwiseButton.lineWidth = 10
        
        clockwiseButton.name = "clockwiseButton"
        
        addChild(clockwiseButton)
        
        createApple()
        
        createSnake()
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "couterClockwiseButton" || touchedNode.name == "clockwiseButton" else { return }
            
            touchedNode.fillColor = .green
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake?.move()
    }
    
    private func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 10)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 10)) + 1)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        addChild(apple)
    }
    
    private func createSnake() {
        let snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        addChild(snake)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collsionObject = bodies ^ CollisionCategories.SnakeHead
        
        switch collsionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.Edge:
            break
        case CollisionCategories.Snake:
            snake?.removeFromParent()
            snake = nil
            createSnake()
        default:
            break
        }
    }
}

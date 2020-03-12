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
        
        self.physicsBody?.categoryBitMask = CollisionCategories.Edge
        self.physicsBody?.contactTestBitMask = CollisionCategories.Edge | CollisionCategories.Snake
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30,
                                                 y: view.scene!.frame.minY + 30)
        
        counterClockwiseButton.fillColor = .lightGray
        counterClockwiseButton.strokeColor = .lightGray
        counterClockwiseButton.lineWidth = 10
        
        counterClockwiseButton.name = "counterClockwiseButton"
        
        addChild(counterClockwiseButton)
        
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

            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else { return }
            
            touchedNode.fillColor = .green

            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else {
                snake!.moveClockwise()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)

            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else { return }
            
            touchedNode.fillColor = .lightGray
        }
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
        snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
        addChild(snake!)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodies ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            debugPrint("Ate apple")
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            apple?.removeFromParent()
            createApple()

            snake?.addBodyPart()
        case CollisionCategories.Edge:
            debugPrint("Collision with field edge")
            snake?.removeFromParent()
            snake = nil
            createSnake()
        case CollisionCategories.Snake:
            debugPrint("Collision with itself")
            snake?.removeFromParent()
            snake = nil
            createSnake()
        default:
            break
        }
    }
}

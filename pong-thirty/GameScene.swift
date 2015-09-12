//
//  GameScene.swift
//  pong:30
//
//  Created by Ryan Arana on 9/1/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball: Ball = Ball(position: .zero)
    var p1: Player = Player(position: .zero)
    var p2: Player = Player(position: .zero)
    var prevUpdateTime: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate

    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

        let p1Sprite = makePlayerSprite()
        p1 = Player(position: CGPoint(x: 50, y: view.bounds.height/2.0))
        p1.addComponent(PlayerControlComponent())
        p1.addComponent(VisualComponent(sprite: p1Sprite))
        self.addChild(p1Sprite)

        let ballSprite = makeBallSprite(CGSize(width: p1Sprite.size.width, height: p1Sprite.size.width))
        ball = Ball(position: CGPoint(x: view.bounds.width/2.0, y: view.bounds.height/2.0))
        ball.addComponent(VisualComponent(sprite: ballSprite))
        addChild(ballSprite)
    }

    func makePlayerSprite() -> SKSpriteNode {
        let h = size.height * 0.23
        return SKSpriteNode(color: .whiteColor(), size: CGSize(width: h * 0.1619, height: h))
    }

    func makeBallSprite(size: CGSize) -> SKSpriteNode {
        return SKSpriteNode(color: .whiteColor(), size: size)
    }

    override func update(currentTime: CFTimeInterval) {
        let delta = currentTime - prevUpdateTime
        ball.updateWithDeltaTime(delta)
        p1.updateWithDeltaTime(delta)
        p2.updateWithDeltaTime(delta)
        prevUpdateTime = currentTime
    }
}

protocol PongEntity {
    var position: CGPoint { get set }
}

class Ball: GKEntity, PongEntity {
    var position: CGPoint
    var velocity = CGVector(dx: 0, dy: 0)
    var maxVelocity = CGVector(dx: 1400, dy: 1400)

    init(position: CGPoint) {
        self.position = position
    }
}

class Player: GKEntity, PongEntity {
    var position: CGPoint

    init(position: CGPoint) {
        self.position = position
    }
}

class VisualComponent: GKComponent {
    let sprite: SKSpriteNode
    init(sprite: SKSpriteNode) {
        self.sprite = sprite
    }
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        guard let entity = entity as? PongEntity else { return }
        sprite.position = entity.position
    }
}

class PlayerControlComponent: GKComponent {
    var target: CGPoint?
    var maxVelocity = CGFloat(1200.0)

    override init() {
        super.init()

        if let entity = entity as? Player {
            target = entity.position
        }
    }

    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        guard let target = target else { return }
        guard let entity = entity as? Player else { return }

        let maxVel = maxVelocity * CGFloat(seconds)
        let minVel = -maxVelocity * CGFloat(seconds)

        let requiredVel = target.y - entity.position.y
        guard requiredVel != 0 else {
            self.target = nil
            return
        }

        var velocity = CGFloat(0)
        if requiredVel > 0 {
            velocity = min(maxVel, requiredVel)
        } else {
            velocity = max(minVel, requiredVel)
        }
        entity.position = CGPoint(x: entity.position.x, y: entity.position.y + velocity)
    }
}


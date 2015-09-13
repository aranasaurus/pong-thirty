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
    var p1: Player
    var p2: Player
    var ball: Ball
    var prevUpdateTime: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate
    private let goalGutter = CGFloat(50)

    override init(size: CGSize) {
        self.p1 = Player(sprite: GameScene.makePlayerSpriteForSceneSize(size))
        self.p2 = Player(sprite: GameScene.makePlayerSpriteForSceneSize(size))
        self.ball = Ball(sprite: GameScene.makeBallSpriteForSceneSize(size))
        super.init(size: size)

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        p1.sprite.position = CGPoint(x: goalGutter, y: size.height/2.0)
        p1.addComponent(PlayerControlComponent())
        self.addChild(p1.sprite)

        p2.sprite.position = CGPoint(x: size.width - goalGutter, y: size.height/2.0)
        p2.addComponent(PlayerControlComponent())
        self.addChild(p2.sprite)

        ball.sprite.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
        addChild(ball.sprite)
        ball.sprite.physicsBody?.applyImpulse(CGVector(dx: 4, dy: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func paddleSizeForSceneSize(sceneSize: CGSize) -> CGSize {
        let h = sceneSize.height * 0.23
        let w = h * 0.1619
        return CGSize(width: w, height: h)
    }

    static func makePlayerSpriteForSceneSize(sceneSize: CGSize) -> SKSpriteNode {
        let sprite = SKSpriteNode(color: .whiteColor(), size: paddleSizeForSceneSize(sceneSize))

        let physBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        physBody.dynamic = false
        sprite.physicsBody = physBody

        return sprite
    }

    static func makeBallSpriteForSceneSize(sceneSize: CGSize) -> SKSpriteNode {
        // ballSize is a square the same size as the paddle
        let paddleSize = paddleSizeForSceneSize(sceneSize)
        let ballSize = CGSize(width: paddleSize.width, height: paddleSize.width)
        let ball = SKSpriteNode(color: .whiteColor(), size: ballSize)
        ball.physicsBody = SKPhysicsBody(rectangleOfSize: ballSize)
        ball.physicsBody?.dynamic = true
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false

        return ball
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
    var sprite: SKSpriteNode { get set }

    init(sprite: SKSpriteNode)
}

class Ball: GKEntity, PongEntity {
    var sprite: SKSpriteNode {
        didSet {
            sprite.position = oldValue.position

            guard let parent = oldValue.parent else { return }
            guard let index = parent.children.indexOf(oldValue) else { return }
            parent.insertChild(sprite, atIndex: index)
            oldValue.removeFromParent()
        }
    }

    required init(sprite: SKSpriteNode) {
        self.sprite = sprite
    }
}

class Player: GKEntity, PongEntity {
    var sprite: SKSpriteNode {
        didSet {
            sprite.position = oldValue.position

            guard let parent = oldValue.parent else { return }
            guard let index = parent.children.indexOf(oldValue) else { return }
            parent.insertChild(sprite, atIndex: index)
            oldValue.removeFromParent()
        }
    }

    required init(sprite: SKSpriteNode) {
        self.sprite = sprite
    }
}

class PlayerControlComponent: GKComponent {
    var target: CGPoint?
    var maxVelocity = CGFloat(1200.0)

    override init() {
        super.init()

        if let entity = entity as? Player {
            target = entity.sprite.position
        }
    }

    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        guard let target = target else { return }
        guard let entity = entity as? Player else { return }

        let maxVel = maxVelocity * CGFloat(seconds)
        let minVel = -maxVelocity * CGFloat(seconds)

        let requiredVel = target.y - entity.sprite.position.y
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
        entity.sprite.position = CGPoint(x: entity.sprite.position.x, y: entity.sprite.position.y + velocity)
    }
}


//
//  GameScene.swift
//  pong:30
//
//  Created by Ryan Arana on 9/1/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import GameKit

class GameScene: SKScene {
    var p1: Player
    var p2: Player
    var ball: Ball
    var prevUpdateTime: NSTimeInterval = NSDate().timeIntervalSinceReferenceDate
    private let goalGutter = CGFloat(50)

    override init(size: CGSize) {
        self.p1 = Player(sceneSize: size)
        self.p2 = Player(sceneSize: size)
        self.ball = Ball(sceneSize: size)
        super.init(size: size)

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        p1.setPosition(CGPoint(x: goalGutter, y: size.height/2.0))
        p1.addComponent(PlayerControlComponent())
        self.addChild(p1.sprite)

        p2.setPosition(CGPoint(x: size.width - goalGutter, y: size.height/2.0))
        p2.addComponent(PlayerControlComponent())
        self.addChild(p2.sprite)

        ball.setPosition(CGPoint(x: size.width/2.0, y: size.height/2.0))
        addChild(ball.sprite)
        // TODO: Make it random
        ball.sprite.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 2.66))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(currentTime: CFTimeInterval) {
        let delta = currentTime - prevUpdateTime
        ball.updateWithDeltaTime(delta)
        p1.updateWithDeltaTime(delta)
        p2.updateWithDeltaTime(delta)
        prevUpdateTime = currentTime
    }
}



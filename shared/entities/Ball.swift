//
//  Ball.swift
//  pong-thirty
//
//  Created by Ryan Arana on 9/13/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import GameKit

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

    required init(sceneSize: CGSize) {
        // ballSize is a square the same size as the paddle
        let paddleSize = Player.paddleSizeForSceneSize(sceneSize)
        let ballSize = CGSize(width: paddleSize.width, height: paddleSize.width)
        self.sprite = SKSpriteNode(color: .whiteColor(), size: ballSize)
        super.init()

        let physicsBody = SKPhysicsBody(rectangleOfSize: ballSize)
        physicsBody.dynamic = true
        physicsBody.restitution = 1
        physicsBody.friction = 0
        physicsBody.linearDamping = 0
        physicsBody.allowsRotation = false
        self.sprite.physicsBody = physicsBody
    }

}

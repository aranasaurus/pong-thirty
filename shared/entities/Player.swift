//
//  Player.swift
//  pong-thirty
//
//  Created by Ryan Arana on 9/13/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import GameKit

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

    required init(sceneSize: CGSize) {
        self.sprite = SKSpriteNode(color: .whiteColor(), size: Player.paddleSizeForSceneSize(sceneSize))
        super.init()

        let physBody = SKPhysicsBody(rectangleOfSize: sprite.size)
        physBody.dynamic = false
        sprite.physicsBody = physBody
    }

    static func paddleSizeForSceneSize(sceneSize: CGSize) -> CGSize {
        let h = sceneSize.height * 0.23
        let w = h * 0.1619
        return CGSize(width: w, height: h)
    }
}


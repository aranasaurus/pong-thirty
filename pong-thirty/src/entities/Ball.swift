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

    required init(sprite: SKSpriteNode) {
        self.sprite = sprite
    }
}

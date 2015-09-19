//
//  PongEntity.swift
//  pong-thirty
//
//  Created by Ryan Arana on 9/13/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import GameKit

protocol PongEntity {
    var sprite: SKSpriteNode { get set }
    var position: CGPoint { get }
    mutating func setPosition(position: CGPoint)

    init(sceneSize: CGSize)
}

extension PongEntity {
    var position: CGPoint {
        get { return sprite.position }
    }
    func setPosition(position: CGPoint) {
        sprite.position = position
    }
}

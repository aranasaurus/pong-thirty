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

    init(sprite: SKSpriteNode)
}

//
//  PlayerController.swift
//  pong-thirty
//
//  Created by Ryan Arana on 9/13/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import GameKit

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

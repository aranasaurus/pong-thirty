//
//  Paddle.swift
//  pong-thirty
//
//  Created by Ryan Arana on 9/1/15.
//  Copyright © 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class Paddle: SKShapeNode {
    static let defaultPaddleSize = CGSize(width: 44, height: 138)

    var touch: UITouch?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(position: CGPoint) {
        super.init()
        self.position = position
        self.path = CGPathCreateWithRect(CGRect(origin: CGPoint.zero, size: Paddle.defaultPaddleSize), nil)
        self.fillColor = .whiteColor()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.position = CGPoint(x: self.position.x, y: self.position.y + (touch.locationInNode(self.parent!).y - touch.previousLocationInNode(self.parent!).y))
        }
    }
}

//
//  GameScene.swift
//  pong:30
//
//  Created by Ryan Arana on 9/1/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let paddle1 = Paddle(position: CGPoint(x: 50, y: 0))
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        paddle1.position = CGPoint(x: 50, y: (view.bounds.height - Paddle.defaultPaddleSize.height)/2.0)
        addChild(paddle1)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if let touch = touches.first where touch.locationInView(self.view!).x < self.view!.bounds.width/2.0 {
            paddle1.touchesBegan(touches, withEvent: event)
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        paddle1.touchesMoved(touches, withEvent: event)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

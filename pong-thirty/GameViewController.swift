//
//  GameViewController.swift
//  pong:30
//
//  Created by Ryan Arana on 9/1/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let skView = self.view as? SKView {
            scene = GameScene(size: skView.bounds.size)

            // Configure the view.
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene!.scaleMode = .AspectFill
            
            skView.presentScene(scene!)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        print("==== didReceiveMemoryWarning! ====")
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where touch.locationInView(self.view!).x < self.view!.bounds.width/2.0 {
            guard let controller = scene?.p1.componentForClass(PlayerControlComponent.self) else { return }
            controller.target = touch.locationInNode(scene!)
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first where touch.locationInView(self.view!).x < self.view!.bounds.width/2.0 {
            guard let controller = scene?.p1.componentForClass(PlayerControlComponent.self) else { return }
            controller.target = touch.locationInNode(scene!)
        }
    }
}

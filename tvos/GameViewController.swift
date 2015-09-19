//
//  GameViewController.swift
//  pong-thirty-tv
//
//  Created by Ryan Arana on 9/18/15.
//  Copyright (c) 2015 OK, Robot Studios. All rights reserved.
//

import GameKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene?
    private let overscanInsets = UIEdgeInsets(top: 33, left: 60, bottom: 33, right: 60)

    override func viewDidLoad() {
        super.viewDidLoad()


        scene = GameScene(size: view.bounds.size, insets: overscanInsets)

        // Configure the view.
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = .AspectFill


        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        print("==== didReceiveMemoryWarning! ====")
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let controller = scene?.p1.componentForClass(PlayerControlComponent.self),
            touch = touches.first
            else { return }
        controller.target = touch.locationInNode(scene!)
    }

}
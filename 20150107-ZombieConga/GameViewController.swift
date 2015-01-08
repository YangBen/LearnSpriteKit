//
//  GameViewController.swift
//  20150107-ZombieConga
//
//  Created by Ben on 15/1/7.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hardcoded, optional for those who are especially curious
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        
        let skView = self.view as SKView;
        skView.showsFPS = true;
        skView.showsNodeCount = true;
        skView.ignoresSiblingOrder = true;  // z position sibling, ignore deepth
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

}

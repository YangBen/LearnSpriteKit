//
//  GameScene.swift
//  20150107-ZombieConga
//
//  Created by Ben on 15/1/7.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var _zombie = SKSpriteNode(imageNamed: "zombie")
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    override func didMoveToView(view: SKView){
        // set background
        backgroundColor = SKColor.whiteColor()
        
        // set background img
        let background = SKSpriteNode(imageNamed: "background")
        let mysize = background.size
        println("Size: \(mysize)")
        
        background.size = size
        background.zPosition = -1
        addChild(background)
        
        // set background img path
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        //------------------------------------------------------------
        
        // add zombie
        _zombie.size = CGSize(width: 340, height: 260)
        _zombie.setScale(2.0)
        _zombie.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(_zombie)
    }
}

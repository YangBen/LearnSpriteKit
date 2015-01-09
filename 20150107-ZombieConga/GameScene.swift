//
//  GameScene.swift
//  20150107-ZombieConga
//
//  Created by Ben on 15/1/7.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let _playableRect: CGRect
    let _zombieRotateRadiansPerSec: CGFloat = 2.0 * π
    
    var _zombie = SKSpriteNode(imageNamed: "zombie")
    var _lastUpdateTime: NSTimeInterval = 0
    var _dt: NSTimeInterval = 0
    var _velocity = CGPointZero
    var _lastTouchLocation = CGPointZero
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, _playableRect)
        shape.path = path
        shape.strokeColor = SKColor.redColor()
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight) / 2.0
        _playableRect = CGRect(x: 0,
            y: playableMargin,
            width: size.width,
            height: playableHeight)
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint){
        sprite.zRotation = CGFloat(atan2(Double(direction.y), Double(direction.x)))
    }
    
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint, rotateRadiansPerSec: CGFloat){
        let angleBetween = shortestAngleBetween(sprite.zRotation, direction.angle())
        let amountToRotate = angleBetween * rotateRadiansPerSec * CGFloat(_dt)
        _zombie.zRotation += amountToRotate
        println("Mark0109: angleBetween \(angleBetween), amountToRotate \(amountToRotate)")
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        // time count
        if _lastUpdateTime > 0 {
            _dt = currentTime - _lastUpdateTime
        }
        _lastUpdateTime = currentTime
        // println("\(dt*1000) milliseconds since last update")
        
        // prepare move
        boundsCheckZombie()
        
        // check stop
        let distance = _zombie.position - _lastTouchLocation
        // println("Distance \(distance.length())")
        if distance.length() < 10.0{
            _velocity = CGPointZero
            return
        }
        
        // move
//        rotateSprite(_zombie, direction: _velocity)
        rotateSprite(_zombie, direction: _velocity, rotateRadiansPerSec:_zombieRotateRadiansPerSec)
        moveSprite(_zombie, velocity: _velocity)
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint){
        let amountToMove = velocity * CGFloat(_dt)
        // println("Amont to move: \(amountToMove)")
        
        sprite.position += amountToMove
    }
    
    func moveZombieToward(location: CGPoint){
        let offset = location - _zombie.position
        let length = offset.length()
        let direction = offset / length
        _velocity = direction * 240
    }
    
    func sceneTouched(touchLocation:CGPoint){
        moveZombieToward(touchLocation)
    }
    
    func boundsCheckZombie(){
        let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(_playableRect))
        let topRight = CGPoint(x: size.width, y: CGRectGetMaxY(_playableRect))
        
        if _zombie.position.x <= bottomLeft.x{
            _zombie.position.x = bottomLeft.x
            _velocity.x = -_velocity.x
        }
        
        if _zombie.position.x >= topRight.x {
            _zombie.position.x = topRight.x
            _velocity.x = -_velocity.x
        }
        
        if _zombie.position.y >= topRight.y {
            _zombie.position.y = topRight.y
            _velocity.y = -_velocity.y
            // println("---\(_zombie.position.y) ---\(_playableRect.size.height)")
        }
        
        if _zombie.position.y <= bottomLeft.y {
            _zombie.position.y = bottomLeft.y
            _velocity.y = -_velocity.y
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
        
        _lastTouchLocation = touchLocation
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
        
        _lastTouchLocation = touchLocation
    }
    
    override func didMoveToView(view: SKView){
        // set background
        backgroundColor = SKColor.whiteColor()
        
        // set background img
        let background = SKSpriteNode(imageNamed: "background")
        let mysize = background.size
        // println("Size: \(mysize)")
        
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
            
        debugDrawPlayableArea()
    }
}

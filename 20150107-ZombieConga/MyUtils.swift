//
//  MyUtils.swift
//  20150107-ZombieConga
//
//  Created by Ben on 15/1/9.
//  Copyright (c) 2015年 Ben. All rights reserved.
//

import Foundation
import CoreGraphics

#if !(arch(x86_64) || arch(arm64))
    
    // 32位下，浮点数默认为Float, 而Swift默认为double, 所以要转换
    func atan2(y:CGFloat, x:CGFloat) -> CGFloat{
        return CGFloat(atan2f(Float(y), Float(x)))
    }
    
    func sqrt(a: CGFloat) -> CGFloat{
        return CGFloat( sqrt(Float(a)) )
    }
#endif
    
func + (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func * (left: CGPoint, scale: CGFloat) -> CGPoint{
    return CGPoint(x: left.x * scale, y: left.y * scale)
}

func / (left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func / (left: CGPoint, scale: CGFloat) -> CGPoint{
    return CGPoint(x: left.x / scale, y: left.y / scale)
}

//-------------------------------------------------------------

func -= (inout left: CGPoint, right: CGPoint){
    left = left - right
}

func += (inout left: CGPoint, right: CGPoint){
    left = left + right
}

func *= (inout left: CGPoint, right: CGPoint){
    left = left * right
}

func /= (inout left: CGPoint, right: CGPoint){
    left = left / right
}

//-------------------------------------------------------------

extension CGPoint{
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint{
        return self / length()
    }
    
    func angle() -> CGFloat {
        return atan2(y, x)
    }
}

extension CGFloat {
    func sign() -> CGFloat {
        return (self >= 0.0) ? 1.0 : -1.0
    }
}

let π = CGFloat(M_PI)

func shortestAngleBetween(angle1: CGFloat, angle2: CGFloat) -> CGFloat {
    var angle = (angle2 - angle1) % (2*π)
    if angle >= π {
        angle = angle - 2 * π
    }
    
    if angle <= -π {
        angle = angle + 2 * π
    }
    
    return angle
}
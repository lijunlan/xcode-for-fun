//
//  MyView.swift
//  Smile
//
//  Created by SDLL18 on 14-10-12.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect:CGRect){
        var bounds :CGRect  = self.bounds
        var centerX = bounds.origin.x+bounds.size.width/2
        var context : CGContextRef  = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, UIColor.yellowColor().CGColor)
        var face : CGRect = CGRect(x:centerX-100, y:50, width: 200,height: 200)
        var eye1 : CGRect = CGRect(x:centerX-50,y:100,width:20,height:20)
        var eye2 : CGRect = CGRect(x:centerX+30,y:100,width:20,height:20)
        CGContextAddEllipseInRect(context, face)
        CGContextAddEllipseInRect(context, eye1)
        CGContextAddEllipseInRect(context, eye2)
        CGContextStrokePath(context)
        CGContextMoveToPoint(context, 102, 170)
        CGContextAddLineToPoint(context, 218, 170)
        CGContextStrokePath(context)
        CGContextAddArc(context, centerX, 150, 60, 160*3.14/180,20*3.14/180, 1)
        CGContextStrokePath(context)
    }
}

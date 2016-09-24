//
//  MyView.swift
//  Smile
//
//  Created by SDLL18 on 14-10-12.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    var smile = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSmile(isSmile:Bool){
        smile=isSmile
        setNeedsDisplay()
    }
    
    func isSmile()->Bool{
        return smile
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
        if(smile){
            CGContextAddArc(context, centerX, 150, 60, 160*3.14/180,20*3.14/180, 1)
        } else{
            CGContextAddArc(context, centerX, 220, 60, 200*3.14/180,340*3.14/180, 0)
        }
        CGContextStrokePath(context);
    }
}

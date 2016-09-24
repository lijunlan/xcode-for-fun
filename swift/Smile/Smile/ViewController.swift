//
//  ViewController.swift
//  Smile
//
//  Created by SDLL18 on 14-10-12.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myView : MyView!
    var btnChange :UIButton = UIButton(frame: CGRect(x:0, y: 0, width: 300, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView = MyView(frame:CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.size.width, height: view.bounds.size.height-100))
        view.addSubview(myView)
        
        btnChange.setTitle("Change Face", forState: UIControlState.Normal)
        btnChange.backgroundColor=UIColor.blueColor()
        btnChange.addTarget(self, action: "changeFace", forControlEvents: UIControlEvents.TouchUpInside)
        btnChange.addTarget(self, action: "changeFace", forControlEvents: UIControlEvents.TouchUpOutside)
        btnChange.addTarget(self, action: "changeColor", forControlEvents: UIControlEvents.TouchDown)
        btnChange.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height-50)
        view.addSubview(btnChange)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func changeFace() {
        myView.setSmile(!myView.isSmile())
        btnChange.backgroundColor=UIColor.blueColor()
    }
    
    func changeColor(){
        btnChange.backgroundColor=UIColor.cyanColor()
    }
}


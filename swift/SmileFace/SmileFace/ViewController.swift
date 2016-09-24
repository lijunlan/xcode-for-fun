//
//  ViewController.swift
//  SmileFace
//
//  Created by SDLL18 on 14-10-13.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myView : FaceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView = FaceView(frame:CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.size.width, height: view.bounds.size.height-100))
        view.addSubview(myView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//
//  SelectScene.swift
//  VolcanoRockEscaping
//
//  Created by SDLL18 on 14/10/23.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import Spritekit


class SelectScene:SKScene {
    
    var level1 : SKLabelNode?
    var level2 : SKLabelNode?
    var level3 : SKLabelNode?
    var level4 : SKLabelNode?
    var level5 : SKLabelNode?
    var level6 : SKLabelNode?
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = UIColor.grayColor()
        
        level1 = SKLabelNode(fontNamed: "Chalkduster")
        level2 = SKLabelNode(fontNamed: "Chalkduster")
        level3 = SKLabelNode(fontNamed: "Chalkduster")
        level4 = SKLabelNode(fontNamed: "Chalkduster")
        level5 = SKLabelNode(fontNamed: "Chalkduster")
        level6 = SKLabelNode(fontNamed: "Chalkduster")
        
        level1!.text = "1"
        level2!.text = "2"
        level3!.text = "3"
        level4!.text = "4"
        level5!.text = "5"
        level6!.text = "6"
        
        level1!.fontSize = 40
        level2!.fontSize = 40
        level3!.fontSize = 40
        level4!.fontSize = 40
        level5!.fontSize = 40
        level6!.fontSize = 40
        
        level1!.fontColor = UIColor.whiteColor()
        level2!.fontColor = UIColor.whiteColor()
        level3!.fontColor = UIColor.whiteColor()
        level4!.fontColor = UIColor.whiteColor()
        level5!.fontColor = UIColor.whiteColor()
        level6!.fontColor = UIColor.whiteColor()
        
        level1!.position = CGPoint(x: frame.width/4, y: CGRectGetMidY(frame))
        level2!.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        level3!.position = CGPoint(x: frame.width/4*3, y: CGRectGetMidY(frame))
        level4!.position = CGPoint(x: frame.width/4, y: CGRectGetMidY(frame)-100)
        level5!.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)-100)
        level6!.position = CGPoint(x: frame.width/4*3, y: CGRectGetMidY(frame)-100)
        
        var l = SKLabelNode(fontNamed: "Chalkduster")
        l.text = "Please select a level"
        l.fontSize = 45
        l.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)+90)
        
        addChild(l)
        addChild(level1!)
        addChild(level2!)
        addChild(level3!)
        addChild(level4!)
        addChild(level5!)
        addChild(level6!)
    
    }
    
    func checkInit(location:CGPoint,level:SKLabelNode)->Bool{
        if((level.position.x-location.x <= level.frame.width/2)&&(level.position.x-location.x >= -level.frame.width/2)){
            if((level.position.y-location.y <= level.frame.height/2)&&(level.position.y-location.y >= -level.frame.height/2)){
                return true
            }
        }
        return false
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if(touches.count>1){return}
        
        let location = touches.anyObject()!.locationInNode(self)
        
        if(checkInit(location, level: level1!)){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : GameScene = GameScene(size: size)
            myScene.scaleMode = .AspectFill
            myScene.actualTime = 30
            myScene.minStone = 2
            myScene.maxStone = 10
            self.view!.presentScene(myScene, transition: reveal)
        }
        else if(checkInit(location, level: level2!)){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : GameScene = GameScene(size: size)
            myScene.scaleMode = .AspectFill
            myScene.actualTime = 60
            myScene.minStone = 3
            myScene.maxStone = 15
            self.view!.presentScene(myScene, transition: reveal)
        }
        else if(checkInit(location, level: level3!)){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : GameScene = GameScene(size: size)
            myScene.scaleMode = .AspectFill
            myScene.actualTime = 60
            myScene.minStone = 5
            myScene.maxStone = 20
            self.view!.presentScene(myScene, transition: reveal)
        }
        else if(checkInit(location, level: level4!)){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : GameScene = GameScene(size: size)
            myScene.scaleMode = .AspectFill
            myScene.actualTime = 100
            myScene.minStone = 7
            myScene.maxStone = 25
            self.view!.presentScene(myScene, transition: reveal)
        }
        else if(checkInit(location, level: level5!)){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : GameScene = GameScene(size: size)
            myScene.scaleMode = .AspectFill
            myScene.actualTime = 100
            myScene.minStone = 9
            myScene.maxStone = 25
            self.view!.presentScene(myScene, transition: reveal)
        }
        else if(checkInit(location, level: level6!)){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : GameScene = GameScene(size: size)
            myScene.scaleMode = .AspectFill
            myScene.actualTime = 100
            myScene.minStone = 11
            myScene.maxStone = 25
            self.view!.presentScene(myScene, transition: reveal)
        }
    }

}

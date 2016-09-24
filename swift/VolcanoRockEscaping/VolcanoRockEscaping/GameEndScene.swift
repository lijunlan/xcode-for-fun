//
//  GameEndScene.swift
//  VolcanoRockEscaping
//
//  Created by SDLL18 on 14/10/23.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import Spritekit


class GameEndScene:SKScene {
    
    init(size: CGSize,won:Bool,score:Int) {
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        var message : NSString?
        if won {
            message = "You Win!"
        }else{
            message = "You Lose!"
        }
        
        var label : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message!
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPointMake(size.width/2, size.height/2+50)
        addChild(label)
        
        var labelScore : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        labelScore.text = "Score:" + score.description
        labelScore.fontSize = 40
        labelScore.fontColor = SKColor.blackColor()
        labelScore.position = CGPointMake(size.width/2, size.height/2-50)
        addChild(labelScore)
        
        runAction(SKAction.sequence([SKAction.waitForDuration(2.0),SKAction.runBlock({
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var myScene : SKScene = SelectScene(size: size)
            myScene.scaleMode = .AspectFill
            self.view!.presentScene(myScene, transition: reveal)
            }
            )]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
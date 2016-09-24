//
//  GameScene.swift
//  VolcanoRockEscaping
//
//  Created by SDLL18 on 14/10/23.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    struct Category{
        
        static let playerCategory : UInt32 = 0x1<<0
        
        static let stoneCategory : UInt32 = 0x1<<1
        
        static let heartCategory : UInt32 = 0x1<<2
    }
    
    
     var isTouched : Bool = false
     var life1 : SKSpriteNode?
     var life2 : SKSpriteNode?
     var life3 : SKSpriteNode?
     var score : SKLabelNode?
     var time : SKLabelNode?
     var player : SKSpriteNode?
     var volcano : SKSpriteNode?
     var stonePT : SKSpriteNode?
    var heartPT : SKSpriteNode?
    
    private var invincible : Bool = false
    
    private var life = 3
    var actualScore : UInt32 = 0
    var _actualTime : Int = 0
    var _minStone : Int = 0
    var _maxStone : Int = 0
    var actualTime : Int{
        get {
            return self._actualTime
        }
        set {
            self._actualTime = newValue
        } 
    }
    var minStone : Int{
        get {
            return self._minStone
        }
        set {
            self._minStone = newValue
        }
    }
    var maxStone : Int{
        get {
            return self._maxStone
        }
        set {
            self._maxStone = newValue
        }
    }
    
    var lastSpawnTimeInterval : NSTimeInterval = 0
    
    var lastUpdateTimeInterval: NSTimeInterval = 0
    
    let kMinTimeInterval = (1.0 / 60.0)
    
    var lastShowTimeInterval : NSTimeInterval = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        physicsWorld.gravity = CGVectorMake(0,-4.0)
        physicsWorld.contactDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit{
        life1 = nil
        life2 = nil
        life3 = nil
        score = nil
        time = nil
        player = nil
        volcano = nil
        stonePT = nil
        heartPT = nil
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.whiteColor()
        var bg = SKSpriteNode(imageNamed: "bg")
        bg.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        bg.name = "BACKGROUND"
        bg.size = frame.size
        addChild(bg)
        
        volcano = SKSpriteNode(imageNamed: "volcano")
        volcano!.position = CGPoint(x:CGRectGetMidX(self.frame), y:volcano!.size.height/2)
        var fire = SKSpriteNode(imageNamed: "fire")
        fire.setScale(0.3)
        fire.position = CGPoint(x:CGRectGetMidX(self.frame)-13, y:volcano!.size.height)
        addChild(fire)
        addChild(volcano!)
        
        var labelLife = SKLabelNode(fontNamed:"Chalkduster")
        labelLife.text = "Life:"
        labelLife.fontSize = 20
        labelLife.fontColor = UIColor.blackColor()
        labelLife.position = CGPoint(x: 35, y: frame.height-25)
        addChild(labelLife)
        life1 = SKSpriteNode(imageNamed: "life")
        life1!.setScale(0.35)
        life1!.position = CGPoint(x: 70, y: frame.height-15)
        addChild(life1!)
        life2 = life1!.copy() as? SKSpriteNode
        life2!.position = CGPoint(x: 90, y: frame.height-15)
        addChild(life2!)
        life3 = life1!.copy() as? SKSpriteNode
        life3!.position = CGPoint(x: 110, y: frame.height-15)
        addChild(life3!)
        
        var labelScore = SKLabelNode(fontNamed:"Chalkduster")
        labelScore.text = "Score:"
        labelScore.fontSize = 20
        labelScore.fontColor = UIColor.blackColor()
        labelScore.position = CGPoint(x: CGRectGetMidX(frame)-60, y: frame.height-25)
        addChild(labelScore)
        score = SKLabelNode(fontNamed:"Chalkduster")
        score!.text = "0"
        score!.fontSize = 20
        score!.fontColor = UIColor.blackColor()
        score!.position = CGPoint(x: CGRectGetMidX(frame)+40, y: frame.height-25)
        addChild(score!)
        
        var labelTime = SKLabelNode(fontNamed:"Chalkduster")
        labelTime.text = "Time:"
        labelTime.fontSize = 20
        labelTime.fontColor = UIColor.blackColor()
        labelTime.position = CGPoint(x: frame.width-150, y: frame.height-25)
        addChild(labelTime)
        time = SKLabelNode(fontNamed:"Chalkduster")
        time!.text = actualTime.description
        time!.fontSize = 20
        time!.fontColor = UIColor.blackColor()
        time!.position = CGPoint(x: frame.width-60, y: frame.height-25)
        addChild(time!)
        
        player = SKSpriteNode(imageNamed: "man")
        player!.setScale(0.4)
        player!.hidden = false
        player!.position = CGPoint(x:CGRectGetMidX(self.frame), y:player!.size.height/2)
        player!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(player!.size.width/3, player!.size.height))
        player!.physicsBody!.dynamic = false
        player!.physicsBody!.categoryBitMask = Category.playerCategory
        player!.physicsBody!.contactTestBitMask = Category.stoneCategory | Category.heartCategory
        player!.physicsBody!.collisionBitMask = 0
        addChild(player!)

        stonePT = SKSpriteNode(imageNamed: "stone")
        
        stonePT!.position = CGPoint(x:CGRectGetMidX(self.frame)-13, y:volcano!.size.height)
        
        stonePT!.physicsBody = SKPhysicsBody(circleOfRadius: stonePT!.size.width/2)
        
        stonePT!.physicsBody!.categoryBitMask = Category.stoneCategory
        
        stonePT!.physicsBody!.contactTestBitMask = Category.playerCategory
        
        stonePT!.physicsBody!.collisionBitMask = 0
        
        heartPT = SKSpriteNode(imageNamed: "projectile")
        
        heartPT!.position = CGPoint(x:CGRectGetMidX(self.frame)-13, y:volcano!.size.height)
        
        heartPT!.physicsBody = SKPhysicsBody(circleOfRadius: heartPT!.size.width/2)
        
        heartPT!.physicsBody!.categoryBitMask = Category.heartCategory
        
        heartPT!.physicsBody!.contactTestBitMask = Category.playerCategory
        
        heartPT!.physicsBody!.collisionBitMask = 0
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if(touches.count>1){return}
        
        let location = touches.anyObject()!.locationInNode(self)
        
        if((player!.position.x-location.x < player!.size.width/2)&&(player!.position.x-location.x > -player!.size.width/2)){
            if((player!.position.y-location.y<player!.size.height/2)&&(player!.position.y-location.y > -player!.size.height/2)){
                isTouched = true
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if(touches.count>1){return}
        
        if(isTouched){
            
            let location = touches.anyObject()!.locationInNode(self)
            
            player!.position = CGPoint(x: location.x, y: player!.position.y)
            
        }
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isTouched = false
    }
    
    func addStone(sum : UInt32){
        var i = sum
        while(i>0){
        
            var stone: SKSpriteNode = stonePT!.copy() as SKSpriteNode
        
            var velocityYMin = 200
            var velocityYMax = 600
            var rangeY = UInt32(velocityYMax - velocityYMin)
            var actualVelocityY = Int(arc4random() % rangeY) + velocityYMin
        
            var velocityXMin = -300
            var velocityXMax = 300
            var rangeX = UInt32(velocityXMax - velocityXMin)
            var actualVelocityX = Int(arc4random() % rangeX) + velocityXMin
        
            stone.physicsBody!.velocity = CGVectorMake(CGFloat(actualVelocityX) , CGFloat(actualVelocityY))
        
            addChild(stone)
            
            i--
        }
    }
    
    func addHeart(sum : UInt32){
        var i = sum
        while(i>0){
            
            var heart: SKSpriteNode = heartPT!.copy() as SKSpriteNode
            
            var velocityYMin = 200
            var velocityYMax = 600
            var rangeY = UInt32(velocityYMax - velocityYMin)
            var actualVelocityY = Int(arc4random() % rangeY) + velocityYMin
            
            var velocityXMin = -300
            var velocityXMax = 300
            var rangeX = UInt32(velocityXMax - velocityXMin)
            var actualVelocityX = Int(arc4random() % rangeX) + velocityXMin
            
            heart.physicsBody!.velocity = CGVectorMake(CGFloat(actualVelocityX) , CGFloat(actualVelocityY))
            
            addChild(heart)
            
            i--
        }
    }
    
    func changeTime(){
        actualTime--
        time!.text = actualTime.description
        if(actualTime<=0){
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var gameEndScene : SKScene = GameEndScene(size: size, won: true, score: Int(actualScore))
            view!.presentScene(gameEndScene, transition: reveal)
        }
    }
    
    func changeScore(){
        score!.text = actualScore.description
    }

    func updateWithTimeSinceLastUpdate(timeSinceLast:NSTimeInterval){
        lastSpawnTimeInterval += timeSinceLast
        lastShowTimeInterval += timeSinceLast
        if lastShowTimeInterval>1 {
            lastShowTimeInterval = 0.0
            changeTime();
        }
        if lastSpawnTimeInterval>2 {
            lastSpawnTimeInterval = 0.0;
            var range = UInt32(maxStone - minStone)
            var actualS  = arc4random() % range + minStone
            addStone(actualS)
            addHeart(actualS/10)
            actualScore += actualS
            changeScore()
        }
    }
   
    override func update(currentTime: NSTimeInterval) {
        /* Called before each frame is rendered */
        var timeSinceLast = currentTime-lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if(timeSinceLast>1){
            timeSinceLast = kMinTimeInterval
        }
        updateWithTimeSinceLastUpdate(timeSinceLast)
    }
    
    func dealContact(player:SKNode,stone:SKNode){
        
        if(invincible){return}
        
        var action0 = SKAction.runBlock({
            self.invincible = true
        })
        var action1 = SKAction.runBlock({
            self.player!.hidden = true
        })
        var action2 = SKAction.runBlock({
            self.player!.hidden = false
        })
        var action3 = SKAction.runBlock({
            self.invincible = false
        })
        
        runAction(SKAction.sequence([action0,action1,SKAction.waitForDuration(0.16),action2,SKAction.waitForDuration(0.16),action1,SKAction.waitForDuration(0.16),action2,action3]))
        
        life--
        
        if life == 2 {
            life3!.hidden = true
        }else if life == 1 {
            life2!.hidden = true
        }else if life == 0 {
            life1!.hidden = true
        }
        
        stone.removeFromParent()
        
        if life<=0 {
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.3)
            var gameEndScene : SKScene = GameEndScene(size: size, won: false, score: Int(actualScore))
            view!.presentScene(gameEndScene, transition: reveal)
        }
    }
    
    func dealHeart(player:SKNode,heart:SKNode){
        actualScore += 10
        changeScore()
        heart.removeFromParent()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody,secondBody :SKPhysicsBody
        
        if contact.bodyA.categoryBitMask<contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if(firstBody.node==nil||secondBody.node==nil){return}
        
        if (((firstBody.categoryBitMask == Category.playerCategory))&&((secondBody.categoryBitMask == Category.stoneCategory))){
            dealContact(firstBody.node!, stone: secondBody.node!)
        }
        else if (((firstBody.categoryBitMask == Category.playerCategory))&&((secondBody.categoryBitMask == Category.heartCategory))){
            dealHeart(firstBody.node!, heart: secondBody.node!)
        }

    }
}

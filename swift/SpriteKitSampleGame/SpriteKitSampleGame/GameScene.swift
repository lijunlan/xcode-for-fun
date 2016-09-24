//
//  GameScene.swift
//  SpriteKitSampleGame
//
//  Created by SDLL18 on 14-10-13.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var player : SKSpriteNode?
    
    private var lastSpawnTimeInterval : CFTimeInterval = 0
    
    private var lastUpdateTimeInterval : CFTimeInterval = 0
    
    private var lastShootTimeInterval : CFTimeInterval = 0
    
    private var monstersDestroyed : Int = 0
    
    private var isTouched : Bool = false
    
    private var bulletPT : SKSpriteNode?
    
    private var monsterPT : SKSpriteNode?
    
    struct Category{
        
        static let monsterCategory : UInt32 = 0x1<<0
        
        static let projectileCategory : UInt32 = 0x1<<1
        
        static let playerCategory : UInt32 = 0x1<<2
    }
    
    class func rwAdd(a:CGPoint,b:CGPoint)->CGPoint{
        return CGPointMake(a.x+b.x, a.y+b.y)
    }
    
    class func rwSub(a:CGPoint,b:CGPoint)->CGPoint{
        return CGPointMake(a.x-b.x, a.y-b.y)
    }
    
    class func rwMult(a:CGPoint,b:CGFloat)->CGPoint{
        return CGPointMake(a.x*b, a.y*b)
    }
    
    class func rwLength(a:CGPoint)->CGFloat{
        return (CGFloat)(sqrtf((Float)(a.x*a.x+a.y*a.y)))
    }
    
    class func rwNormalize(a:CGPoint)->CGPoint {
        var length = rwLength(a)
        return CGPointMake(a.x/length, a.y/length)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit{
        player = nil
        bulletPT = nil
        monsterPT = nil
        NSLog("instance has been destoried")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        
        player = SKSpriteNode(imageNamed: "Spaceship")
        
        player!.setScale(0.15)
        
        player!.position = CGPointMake(view.bounds.size.width/2, player!.size.height*2)
        
        player!.physicsBody = SKPhysicsBody(rectangleOfSize: player!.size)
        
        player!.physicsBody!.dynamic = true
        
        player!.physicsBody!.categoryBitMask = Category.playerCategory
        
        player!.physicsBody!.contactTestBitMask = Category.monsterCategory
        
        player!.physicsBody!.collisionBitMask = 0
        
        self.addChild(player!)
        
        monsterPT = SKSpriteNode(imageNamed: "monster")
        
        monsterPT!.physicsBody = SKPhysicsBody(rectangleOfSize: monsterPT!.size)
        
        monsterPT!.physicsBody!.dynamic = true
        
        monsterPT!.physicsBody!.categoryBitMask = Category.monsterCategory
        
        monsterPT!.physicsBody!.contactTestBitMask = Category.projectileCategory | Category.playerCategory
        
        monsterPT!.physicsBody!.collisionBitMask = 0
        
        bulletPT  = SKSpriteNode(imageNamed: "projectile")
        
        bulletPT!.physicsBody = SKPhysicsBody(circleOfRadius: bulletPT!.size.width/2)
        
        bulletPT!.physicsBody!.dynamic = true
        
        bulletPT!.physicsBody!.categoryBitMask = Category.projectileCategory
        
        bulletPT!.physicsBody!.contactTestBitMask = Category.monsterCategory
        
        bulletPT!.physicsBody!.collisionBitMask = 0
    }
    
    func dealContact(projectile:SKNode,monster:SKNode){
        monstersDestroyed++
        if monstersDestroyed>100 {
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            var gameOverScene : SKScene = GameOverScene(size: size, won: true)
            view!.presentScene(gameOverScene, transition: reveal)
        }
        runAction(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        projectile.removeFromParent()
        monster.removeFromParent()
    }
    
    func dealLose(){
        var actionLose : SKAction = SKAction.runBlock({
            var reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            var gameOverScene = GameOverScene(size: self.size, won: false)
            self.view!.presentScene(gameOverScene, transition: reveal)
        })
        runAction(actionLose)
    }
    
    func addMonster(num:Int){
        var i = num
        while(i>0){
            var monster : SKSpriteNode = monsterPT!.copy() as SKSpriteNode
            var minX = Int(monster.size.width/2)
            var maxX = Int(frame.size.width-monster.size.width/2)
            var rangeX = UInt32(maxX - minX)
            var actualX = Int(arc4random() % rangeX) + minX
            var actualXEnd = Int(arc4random() % rangeX) + minX
        
            monster.position = CGPointMake(CGFloat(actualX) , frame.size.height+monster.size.height/2)
        
            addChild(monster)
        
            var minDuration = 1
            var maxDuration = 6
            var rangeDuration = UInt32(maxDuration-minDuration)
            var actualDuration = Int(arc4random() % rangeDuration) + minDuration
        
            var actionMove : SKAction = SKAction.moveTo(CGPointMake(CGFloat(actualXEnd), -monster.size.height/2), duration: (Double)(actualDuration))
        
            var actionMoveDone : SKAction = SKAction.removeFromParent()
        
            monster.runAction(SKAction.sequence([actionMove,actionMoveDone]))
            i--
        }
    }
    
    func addAllBullet(num:Int){
        
        for(var i = -num/2;i<=num/2;i++){
            var bullet : SKSpriteNode = bulletPT!.copy() as SKSpriteNode
            addBullet(i, bullet: bullet)
        }
    }
    
    func addBullet(kind:Int,bullet:SKSpriteNode){
        
        bullet.position = CGPointMake(player!.position.x+(CGFloat)(kind)*bullet.size.width, player!.position.y+player!.size.height/2+bullet.size.height/2)
        
        addChild(bullet)
        
        var velocity = 1000.0/1.0
        
        var realMoveDuration = (size.height-bullet.position.y)/(CGFloat)(velocity)
        
        var actionMove : SKAction = SKAction.moveTo(CGPointMake(bullet.position.x, size.height+bullet.size.height/2), duration: (Double)(realMoveDuration))
        
        var actionMoveDone : SKAction = SKAction.removeFromParent()
        
        bullet.runAction(SKAction.sequence([actionMove,actionMoveDone]))
    }
    
    func updateWithTimeSinceLastUpdate(timeSinceLast:CFTimeInterval){
        lastSpawnTimeInterval += timeSinceLast
        lastShootTimeInterval += timeSinceLast
        if lastSpawnTimeInterval>1 {
            lastSpawnTimeInterval = 0.0;
            addMonster(3)
        }
        if(lastShootTimeInterval>0.15){
            lastShootTimeInterval = 0.0;
            addAllBullet(5)
        }
        
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
        
            player!.position = CGPoint(x: location.x, y: location.y)
        }
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isTouched = false
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var timeSinceLast : CFTimeInterval  = currentTime-lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if(timeSinceLast>1){
            timeSinceLast = 1.0/60.0
            lastUpdateTimeInterval = currentTime
        }
        updateWithTimeSinceLastUpdate(timeSinceLast)
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
        
        if (((firstBody.categoryBitMask == Category.monsterCategory))&&((secondBody.categoryBitMask == Category.projectileCategory))){
            dealContact(firstBody.node!, monster: secondBody.node!)
        }
        else if (((firstBody.categoryBitMask == Category.monsterCategory))&&((secondBody.categoryBitMask == Category.playerCategory))){
            dealLose()
        }
    }
}

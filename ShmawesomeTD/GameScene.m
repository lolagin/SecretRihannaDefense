//
//  GameScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/22/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "GameScene.h"
#import "Mobs.h"
#import "Turrets.h"
#import "Hud.h"
#import "BaseShip.h"
#import "TurretStore.h"
#import "SKScene+UtilityFunctions.h"
#import "GameOverScene.h"






@interface GameScene () <DeathProtocol, SKPhysicsContactDelegate>


@property (assign, nonatomic) BOOL waveRunning;
@property (assign, nonatomic) BOOL gameRunning;

@property (strong, nonatomic) NSMutableArray *turretBank;
@property (strong, nonatomic) NSMutableArray *mobBank; //current wave
@property (strong, nonatomic) NSMutableArray *waveBank; //?????

@property (strong, nonatomic) SKLightNode *lighting;
@property (strong, nonatomic) SKLabelNode *welcomeLabel;
@property (strong, nonatomic) BaseShip *towerBase;
@property (strong, nonatomic) Hud *mainHud;
@property (strong, nonatomic) SKSpriteNode *bgNode1;
@property (strong, nonatomic) SKSpriteNode *bgNode2;
@property (strong, nonatomic) SKSpriteNode *bgNode3;


@property (strong) NSMutableArray* contactQueue;
//-intro method in viewdidload-- series of label node actions, squad taking fire and going down. superships are tasked with whatever
// ^^ -present label with character and message

//- spawn enemies in lanes, screen/6 or whatever. trails of particle smoke


@end



@implementation GameScene
-(void)switchBackground{
    self.bgNode3.texture = self.bgNode1.texture;
    self.bgNode3.alpha = 1.0;
    [self addChild:self.bgNode3];
    self.bgNode1.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"lultum%lu",self.mainHud.playerLevel]];
    self.bgNode2.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"lultum%lu",self.mainHud.playerLevel]];
    [self.bgNode3 runAction:[SKAction fadeOutWithDuration:1.0]completion:^{
        [self.bgNode3 removeFromParent];
    }];
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.contactQueue = [NSMutableArray array];
    self.physicsWorld.contactDelegate = self;
//    self.physicsBody.categoryBitMask = kSceneEdgeCategory;
//    CGRect bodyRect = CGRectMake(-self.size.width, -self.size.height, self.size.width * 3, self.size.height * 3);
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.view.bounds];
    [self addChild:self.towerBase];
    [self addChild:self.bgNode1];
    [self addChild:self.bgNode2];
    [self addChild:self.welcomeLabel];
    self.mainHud =  [Hud defaultHudWithWidth:self.size.width];
    self.mainHud.position = CGPointMake(0, self.size.height-self.mainHud.size.height);
    [self addChild:self.mainHud];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (!self.gameRunning) return;
    //    self fly mobs (use backgrounf method really )
    [self processContactsForUpdate:currentTime];
    [self bumpNodes:self.bgNode1 and:self.bgNode2];
}







#pragma mark ||touches||
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if ([node isEqualToNode:self.welcomeLabel]) {
            [self playTheFuckingGame];
            [self.welcomeLabel removeFromParent];
            return;
        }
        if ([node isKindOfClass:[Turrets class]]){
//            [self upgradeTurret: (Turrets *)node upgrade];
            return;
            
        }
        if ([node isKindOfClass:[Mobs class]]){
            [((Mobs *)node) takeDamage:100];
        }
    }
}

-(void)mobDeathWithPoints:(NSUInteger)points{
    [self.mainHud updateScore:points];
    NSLog(@"a mob has ded");
}


#pragma mark ||contacts||
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    [self.contactQueue addObject:contact];
    
}

-(void)bulletContact:(SKPhysicsContact *)contact{
    //    if (!contact.bodyA.node.parent || !contact.bodyB.node.parent) return;
    if (((contact.bodyA.node.class == [Mobs class]) || (contact.bodyB.node.class == [Mobs class]))&& ((contact.bodyA.node.class == [SKSpriteNode class]) || (contact.bodyB.node.class == [SKSpriteNode class]))) {
        SKNode *carrot = contact.bodyA.class == [SKSpriteNode class] ? contact.bodyA.node : contact.bodyB.node;
        Mobs *mob = contact.bodyA.node.class == [Mobs class] ? (Mobs *)contact.bodyA.node : (Mobs *)contact.bodyB.node;
        [mob takeDamage:100];
        [carrot runAction:[SKAction removeFromParent]];
        
        
        
        //        SKSpriteNode *firstNode = (SKSpriteNode *)contact.bodyA.node;
        //        Mobs *secondNode = (Mobs *)contact.bodyB.node;
        //        [secondNode removeAllActions];
        //        [secondNode takeDamage:100];
        //        [firstNode removeFromParent];
        //    }   else if (contact.bodyA.categoryBitMask == kInvaderCategory) {
        //        SKSpriteNode *firstNode = (SKSpriteNode *)contact.bodyB.node;
        //        Mobs *secondNode = (Mobs *)contact.bodyA.node;
        //        [secondNode removeAllActions];
        //        [secondNode takeDamage:100];
        //        [firstNode removeFromParent];
    }
}

-(void)processContactsForUpdate:(NSTimeInterval)currentTime {
    for (SKPhysicsContact* contact in [self.contactQueue copy]) {
        [self bulletContact:contact];
        [self.contactQueue removeObject:contact];
    }
}


#pragma mark ||game commands||


-(void)transitionScenesEndGame{
    CIFilter *filter = [CIFilter filterWithName:@"CIBoxBlur"];

    SKTransition *tranny = [SKTransition transitionWithCIFilter:filter duration:1.5];
    GameOverScene *gameScene = [[GameOverScene alloc] initWithSize:self.scene.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:gameScene transition:tranny];
}


-(void)playTheFuckingGame{
    [self sendMobProperly];
    [self fireBullets];
    self.gameRunning = YES;
}
-(void)fireBullets{
    if (!self.towerBase) return;
    [[self.towerBase children] enumerateObjectsUsingBlock:^(Turrets *turat, NSUInteger idx, BOOL *stop) {
        [turat launchCarrots];
    }];
}


-(void)prepNextWave{
    if ([self.waveBank count] == 0) {
        [self transitionScenesEndGame];
        return;
//        END GAME situation, score sum etc..
    }
    self.mobBank = nil;
    self.welcomeLabel.text = @"Nice job buddy! try another??";
    [self.mainHud levelup];
    [self switchBackground];
    [self.towerBase.children enumerateObjectsUsingBlock:^(Turrets *turret, NSUInteger idx, BOOL *stop) {
        [turret stopBullets];
    }];
    [self addChild:self.welcomeLabel];
}

     
     
-(void)sendMobProperly{
    if ([self.mobBank count] == 0) {
    [self.waveBank removeObjectAtIndex:0];
        [self prepNextWave];
        return;
    }
    Mobs *mob = ((Mobs *)self.mobBank[0]);
    mob.delegate = self;
    CGFloat randPos = ((arc4random_uniform(6) + 1) * (self.size.width / 7));
    mob.position = CGPointMake(randPos, self.size.height);
    mob.size = CGSizeMake(self.size.width / 12, self.size.height / 8);
    mob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:mob.size];
    [self addChild:mob];
    SKAction *flight = [SKAction moveToY:-200.0 duration:mob.mobSpeed];
    [mob runAction:flight completion:^{
        [mob removeFromParent];
    }];
    [self runAction:[SKAction waitForDuration:1.0]completion:^{
        [self.mobBank removeObjectAtIndex:0];
        [self sendMobProperly];
    }];
}

#pragma mark  - GETTRZ - custom


-(SKSpriteNode *)bgNode1 {
    if (!_bgNode1){
        _bgNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"lultum1"];
        _bgNode1.zPosition = -5;
        _bgNode1.position = CGPointMake(self.size.width/2, self.size.height/2);
    }
    return _bgNode1;
}


-(SKSpriteNode *)bgNode2 {
    if (!_bgNode2){
        _bgNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"lultum1"];
        _bgNode2.zPosition = -5;
        _bgNode2.position = CGPointMake(self.size.width/2, self.size.height/2 + _bgNode2.size.height-1);
    }
    return _bgNode2;
}
-(SKSpriteNode *)bgNode3 {
    if (!_bgNode3){
        _bgNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"lultum1"];
        _bgNode3.zPosition = -4;
        _bgNode3.position = CGPointMake(self.size.width/2, self.size.height/2);
    }
    return _bgNode3;
}
-(SKSpriteNode *)towerBase{
    if (_towerBase) return _towerBase;
        _towerBase = [BaseShip defaultBaseWithWidth:CGRectGetMidX(self.frame)];
    _towerBase.anchorPoint = CGPointMake(0, 0);
    _towerBase.position = CGPointMake(self.size.width/4, CGRectGetMinY(_towerBase.frame));
    return _towerBase;
}

-(SKLabelNode *)welcomeLabel {
    if (_welcomeLabel) return _welcomeLabel;
        _welcomeLabel = [SKLabelNode labelNodeWithText:@"welcome to teh video game!"];
        _welcomeLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        _welcomeLabel.zPosition = 10;
    return _welcomeLabel;
}

-(NSMutableArray *)waveBank{
    if (_waveBank) return _waveBank;
//        just make all the mob arrays here? set self.mobbank to current and wipe it when iterated through. if !WB builds the waves, then ever get
        _waveBank = [NSMutableArray array];
        [_waveBank addObject:[self randomWaveOfSize:4]];
        [_waveBank addObject:[self randomWaveOfSize:4]];
        [_waveBank addObject:[self randomWaveOfSize:4]];
    return _waveBank;
}

-(NSMutableArray *)randomWaveOfSize:(NSInteger)waveSize{
    NSMutableArray *lulRay = [NSMutableArray array];
    for (int i = 0; i < waveSize; i++) {
        NSInteger lul = arc4random_uniform(5);
        switch (lul) {
            case 0:
                [lulRay addObject:[Mobs defaultMob]];
                break;
            case 1:
                [lulRay addObject:[Mobs lightMob]];
                break;
            case 2:
                [lulRay addObject:[Mobs mediumMob]];
                break;
            case 3:
                [lulRay addObject:[Mobs heavyMob]];
                break;
            case 4:
                [lulRay addObject:[Mobs kanyeMob]];
                break;
            default:
                break;
        }
                NSInteger lulboss = arc4random_uniform(5);
        if (lulboss == 1) {
            [lulRay addObject:[Mobs bossMob]];
        }
    }
    return lulRay;
}

-(NSMutableArray *)mobBank{
    if (!_mobBank){
        _mobBank = [NSMutableArray array];
        _mobBank = self.waveBank[0];
    }
    return _mobBank;
}
-(SKLightNode *)lighting{
    if (_lighting) return _lighting;
    _lighting = [SKLightNode node];
    _lighting.position = CGPointMake(self.size.width/2,self.size.height/2);
    _lighting.enabled = YES;
    _lighting.ambientColor = [SKColor whiteColor];
    _lighting.lightColor = [SKColor whiteColor];
    return _lighting;
}

@end
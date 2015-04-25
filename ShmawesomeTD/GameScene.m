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

@interface GameScene () <DeathProtocol>


@property (assign, nonatomic) BOOL waveRunning;


@property (strong, nonatomic) NSMutableArray *turretBank;
@property (strong, nonatomic) NSMutableArray *mobBank; //current wave
@property (strong, nonatomic) NSMutableArray *waveBank; //?????

@property (strong, nonatomic) SKLabelNode *welcomeLabel;
@property (strong, nonatomic) SKSpriteNode *towerBase;
@property (strong, nonatomic) SKSpriteNode *bgNode1;
@property (strong, nonatomic) SKSpriteNode *bgNode2;
@property (strong, nonatomic) NSTimer *mobTimer;
//-intro method in viewdidload-- series of label node actions, squad taking fire and going down. superships are tasked with whatever
// ^^ -present label with character and message

//- spawn enemies in lanes, screen/6 or whatever. trails of particle smoke


@end



@implementation GameScene




-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */


    [self spawnBaseShip];
    [self addChild:self.welcomeLabel];
}



#pragma mark ||touches||
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if ([node isEqualToNode:self.welcomeLabel]) {
        [self sendMobProperly];
        [self.welcomeLabel removeFromParent];
        }
//    spawn particlz frm node emittr
        if ([node isKindOfClass:[Mobs class]]){
            [((Mobs *)node) takeDamage:100];
//            [node removeFromParent];
        }
 
        

    }
}




-(void)mobDeath {
    NSLog(@"ded");
}





-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

    
    [self bumpBackground];
    
}



-(void)bumpBackground{
    
    
    self.bgNode1.position = CGPointMake(self.bgNode1.position.x, self.bgNode1.position.y-4);
    self.bgNode2.position = CGPointMake(self.bgNode2.position.x, self.bgNode2.position.y-4);
    
    if (self.bgNode1.position.y < -self.bgNode1.size.height){
        self.bgNode1.position = CGPointMake(self.bgNode1.position.x, self.bgNode2.position.y + self.bgNode2.size.height);
    }
    
    if (self.bgNode2.position.y < -self.bgNode2.size.height) {
        self.bgNode2.position = CGPointMake(self.bgNode2.position.x, self.bgNode1.position.y + self.bgNode1.size.height);
    }
    
}

-(void)spawnBaseShip{
    [self addChild:self.towerBase];
    
    
}
-(void)fireBullets{
    if (!self.towerBase) return;
    [[self.towerBase children] enumerateObjectsUsingBlock:^(Turrets *turat, NSUInteger idx, BOOL *stop) {

        
//        FOr turrets in towerbase, [Turret Fire]
        
        SKAction *carrotSequence = [SKAction runBlock:^{
            
        SKSpriteNode *carrotz = [SKSpriteNode spriteNodeWithImageNamed:@"carrotMissile"];
            carrotz.position = CGPointMake(turat.position.x, turat.position.y);
            [self.towerBase addChild:carrotz];
            SKAction *fire = [SKAction moveToY:(self.size.height + 100) duration:1.0];
            [carrotz runAction:fire];
            
            
            
        }];
        
        SKAction *wait = [SKAction waitForDuration:turat.fireRate];
        SKAction *machineGun = [SKAction repeatActionForever:[SKAction sequence:@[carrotSequence,wait]]];
        [self runAction:machineGun];
    
    }];
    
}



-(void)sendMobProperly{

    if ([self.mobBank count] == 0) {
        self.mobBank = nil;

        self.welcomeLabel.text = @"Nice job buddy! try another??";
        [self addChild:self.welcomeLabel];
        return;
    }

    Mobs *mob = ((Mobs *)self.mobBank[0]);
    mob.delegate = self;
    mob.size = CGSizeMake(self.size.width / 8, self.size.height / 8);
    SKAction *flight = [SKAction moveToY:-200.0 duration:mob.mobSpeed];
            CGFloat randPos = ((arc4random_uniform(6) + 1) * (self.size.width / 7));
            mob.position = CGPointMake(randPos, self.size.height);
            [self addChild:mob];
            [mob runAction:flight completion:^{
            [mob removeFromParent];
        }];
        [self runAction:[SKAction waitForDuration:1.0]completion:^{
        [self.mobBank removeObjectAtIndex:0];
        self.waveRunning = NO;
        [self sendMobProperly];
    }];
}

#pragma mark  - GETTRZ - custom


-(SKSpriteNode *)bgNode1 {
    if (!_bgNode1){
        _bgNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"sideBack"];
        _bgNode1.zPosition = -5;
        _bgNode1.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:_bgNode1];
    }
    return _bgNode1;
}


-(SKSpriteNode *)bgNode2 {
    if (!_bgNode2){
        _bgNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"sideBack"];
        _bgNode2.zPosition = -5;
        _bgNode2.position = CGPointMake(self.size.width/2, self.size.height/2 + _bgNode2.size.height-1);
        [self addChild:_bgNode2];
    }
    return _bgNode2;
}

-(SKSpriteNode *)towerBase{
    if (!_towerBase){
        _towerBase = [SKSpriteNode spriteNodeWithImageNamed:@"towerBase"];

        _towerBase.anchorPoint = CGPointZero;
        _towerBase.position = CGPointMake(_towerBase.frame.size.width / 2, 0);

        for (int i = 0; i<5; i++) {
            [_towerBase addChild:[Turrets defaultTurret]];
            ((SKNode *)[_towerBase children][i]).position = CGPointMake((_towerBase.size.width / 6) * (i+1), 50);
        }
        [[_towerBase children] enumerateObjectsUsingBlock:^(Turrets *turat, NSUInteger idx, BOOL *stop) {
//            turat.position = CGPointMake(self.size.width / ([[_towerBase children] count] + 1) * ((idx+1)), 0);
//            (-_towerBase.size.width / 2)
            NSLog(@"turret at %@",NSStringFromCGPoint(turat.position));
        }];
        NSLog(@"self.frame = %@",NSStringFromCGRect(self.frame));
        NSLog(@"towerbase frame = %@",NSStringFromCGRect(_towerBase.frame));
        NSLog(@"%lu",(unsigned long)[[_towerBase children] count]);
        [self fireBullets];
    }
    return _towerBase;
}

-(SKLabelNode *)welcomeLabel {
    if (!_welcomeLabel) {
        _welcomeLabel = [SKLabelNode labelNodeWithText:@"welcome to teh video game!"];
        _welcomeLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    }
    return _welcomeLabel;
}

-(NSMutableArray *)waveBank{
    if (!_waveBank){
        
//        just make all the mob arrays here? set self.mobbank to current and wipe it when iterated through. if !WB builds the waves, then ever get
        
        
        _waveBank = [NSMutableArray array];
        [_waveBank addObject:self.mobBank];
        [_waveBank addObject:self.mobBank];
        [_waveBank addObject:self.mobBank];
        [_waveBank addObject:self.mobBank];
        [_waveBank addObject:self.mobBank];
    }
    return _waveBank;
}

-(NSMutableArray *)mobBank{
    if (!_mobBank){
        _mobBank = [NSMutableArray array];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs mediumMob]];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs heavyMob]];
        [_mobBank addObject:[Mobs lightMob]];
        [_mobBank addObject:[Mobs heavyMob]];
        [_mobBank addObject:[Mobs heavyMob]];
        [_mobBank addObject:[Mobs lightMob]];
        [_mobBank addObject:[Mobs mediumMob]];
        [_mobBank addObject:[Mobs lightMob]];
        [_mobBank addObject:[Mobs heavyMob]];
        [_mobBank addObject:[Mobs heavyMob]];
        [_mobBank addObject:[Mobs heavyMob]];
    }
    return _mobBank;
}


@end
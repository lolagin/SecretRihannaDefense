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


    [self addChild:self.towerBase];
    [self addChild:self.welcomeLabel];
    [self addChild:self.bgNode1];
    [self addChild:self.bgNode2];
    }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if ([node isEqualToNode:self.welcomeLabel]) {
        [self sendMobProperly];
        [self.welcomeLabel removeFromParent];
        }
/*        spawn particlz frm node emittr
        if ([node isKindOfClass:[Mobs class]]){
            [((Mobs *)node) takeDamage:100];
            [node removeFromParent];
        } 
 */
        

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


-(void)sendMobProperly{

    if ([self.mobBank count] == 0) {
        self.mobBank = nil;
        self.waveRunning = NO;
        self.welcomeLabel.text = @"Nice job buddy! try another??";
        [self addChild:self.welcomeLabel];
        return;
    }
    self.waveRunning = YES;
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
    }
    return _bgNode1;
}


-(SKSpriteNode *)bgNode2 {
    if (!_bgNode2){
        _bgNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"sideBack"];
        _bgNode2.zPosition = -5;
        _bgNode2.position = CGPointMake(self.size.width/2, self.size.height/2 + _bgNode2.size.height-1);
    }
    return _bgNode2;
}

-(SKSpriteNode *)towerBase{
    if (!_towerBase){
        _towerBase = [SKSpriteNode spriteNodeWithImageNamed:@"towerBase"];
        _towerBase.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(_towerBase.frame)+ 20);
        [_towerBase addChild:[Turrets defaultTurret]];
        [_towerBase addChild:[Turrets defaultTurret]];
        [_towerBase addChild:[Turrets defaultTurret]];
        [_towerBase addChild:[Turrets defaultTurret]];
        [_towerBase addChild:[Turrets defaultTurret]];
        [[_towerBase children] enumerateObjectsUsingBlock:^(Turrets *turat, NSUInteger idx, BOOL *stop) {
            turat.position = CGPointMake(_towerBase.size.width * ((idx+1) / [[_towerBase children] count]),CGRectGetMidY(_towerBase.frame));
        }];
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
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs defaultMob]];
        [_mobBank addObject:[Mobs defaultMob]];
    }
    return _mobBank;
}


@end
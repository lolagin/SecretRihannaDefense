//
//  Hud.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Hud.h"


@interface Hud ()


@property (strong, nonatomic) SKSpriteNode *lifeBox;
@property (strong, nonatomic) SKSpriteNode *levelBox;
@property (strong, nonatomic) SKSpriteNode *scoreBox;

@property (strong, nonatomic)SKLabelNode *scoreLabel;
@property (strong, nonatomic)SKLabelNode *levelLabel;
@end

@implementation Hud

-(void)levelup{
    self.playerLevel++;
    self.levelLabel.text = [NSString stringWithFormat:@"%lu",self.playerLevel];
}
-(void)updateScore:(NSUInteger)points{
    NSLog(@"a def has happen");
    self.playerScore += points;
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu",self.playerScore];
}



-(instancetype)initWithWidth:(NSUInteger)width{
    if(self = [super init]){
    self.playerLives = 5;
        self.playerScore = 0;
        self.playerLevel = 1;
    self.size = CGSizeMake(width, width/12);
    self.color = [UIColor blackColor];
    self.alpha = 0.85;
    self.anchorPoint = CGPointMake(0, 0);
        self.zPosition = 20;
    [self addChild:self.lifeBox];
    [self addChild:self.levelBox];
    [self addChild:self.scoreBox];
    }
    return self;
}

+(instancetype)defaultHudWithWidth:(NSUInteger)width{
    Hud *hud = [[Hud alloc] initWithWidth:width];
//    hud.position = CGPointMake(CGRectGetMidX(hud.ancestralBounds), CGRectGetMidY(hud.ancestralBounds));
//    hud.zPosition = 15;
//    [hud addChild:hud.levelBox];
//    [hud addChild:hud.lifeBox];
//    [hud addChild:hud.scoreBox];
    
    return hud;
}

-(SKSpriteNode *)lifeBox{
    if (_lifeBox) return _lifeBox;
    _lifeBox = [SKSpriteNode node];
    _lifeBox.color = [SKColor colorWithRed:90/255 green:45/255 blue:100/255 alpha:0.5];
//    _lifeBox.anchorPoint = CGPointMake(0, 0);
    _lifeBox.anchorPoint = CGPointMake(0.0, 0.0);
    _lifeBox.size = CGSizeMake(self.size.width/4,self.size.height);
    _lifeBox.position = CGPointMake((self.size.width/8)*3, 0);
    for (int i = 0; i < self.playerLives; i++) {
        SKSpriteNode *life = [SKSpriteNode spriteNodeWithImageNamed:@"lifeToken"];
        life.alpha = 0.7;
        life.anchorPoint =  CGPointMake(0.0, 0.5);
        life.size = CGSizeMake(_lifeBox.frame.size.width/self.playerLives, self.size.height/2);
        life.position = CGPointMake(life.size.width * i, _lifeBox.size.height/2);
        [_lifeBox addChild:life];
    }
    return _lifeBox;
}

//-(SKLabelNode *)levelBox{
//    if (_levelBox) return _levelBox;
//    _levelBox = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"Level %lu",(unsigned long)self.level]];
//    _levelBox.fontColor = [SKColor whiteColor];
//    _levelBox.position = CGPointMake(2, self.size.height/2);
//    return _levelBox;
//}

-(SKSpriteNode *)levelBox{
    if (_levelBox) return _levelBox;
    _levelBox = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(self.size.width/3, self.size.height)];
    _levelBox.position = CGPointMake((self.size.width/3), 4);
    SKLabelNode *label = [SKLabelNode labelNodeWithText:@"Level"];
    label.fontColor = [SKColor whiteColor];
    label.color = [SKColor blackColor];
    label.position = CGPointMake(0, _levelBox.size.height/2);
    [_levelBox addChild:label];
    self.levelLabel = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%lu",(unsigned long)self.playerLevel]];
    self.levelLabel.fontColor = [SKColor whiteColor];
    self.levelLabel.color = [SKColor blackColor];
    self.levelLabel.position = CGPointMake(0, 0);
    [_levelBox addChild:self.levelLabel];
    return _levelBox;
}



-(SKSpriteNode *)scoreBox{
    if (_scoreBox) return _scoreBox;
    _scoreBox = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(self.size.width/3, self.size.height)];
    _scoreBox.position = CGPointMake((self.size.width/3)*2, 4);
    SKLabelNode *label = [SKLabelNode labelNodeWithText:@"Score"];
    label.fontColor = [SKColor whiteColor];
    label.color = [SKColor blackColor];
    label.position = CGPointMake(0, _scoreBox.size.height/2);
    [_scoreBox addChild:label];
    self.scoreLabel = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%lu",self.playerScore]];
    self.scoreLabel.fontColor = [SKColor whiteColor];
    self.scoreLabel.color = [SKColor blackColor];
    self.scoreLabel.position = CGPointMake(0, 0);
    [_scoreBox addChild:self.scoreLabel];
    return _scoreBox;
}








@end

//
//  Hud.h
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@interface Hud : SKSpriteNode

@property (assign, nonatomic) NSUInteger playerLives;
@property (assign, nonatomic) NSUInteger playerLevel;
@property (assign, nonatomic) NSUInteger playerScore;

+(instancetype)defaultHudWithWidth:(NSUInteger)width;
-(void)levelup;
-(void)updateScore:(NSUInteger)points;
@end
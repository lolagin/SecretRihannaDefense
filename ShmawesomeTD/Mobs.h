//
//  Mobs.h
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class GameScene;
@protocol DeathProtocol
-(void)mobDeathWithPoints:(NSUInteger)points;
@end

@interface Mobs : SKSpriteNode

@property (nonatomic, weak) id<DeathProtocol> delegate;
@property (nonatomic) NSUInteger mobHealth;
@property (nonatomic) NSUInteger mobPointReward;
@property (nonatomic) CGFloat mobSpeed;
+(instancetype)defaultMob;
+(instancetype)lightMob;
+(instancetype)mediumMob;
+(instancetype)heavyMob;
+(instancetype)kanyeMob;
+(instancetype)bossMob;
+(instancetype)bobMob;
+(instancetype)patMob;
-(void)takeDamage:(NSUInteger)damage;

@end

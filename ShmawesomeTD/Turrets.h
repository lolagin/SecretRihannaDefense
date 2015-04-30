//
//  Turrets.h
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Turrets : SKSpriteNode
@property (assign, nonatomic) NSUInteger fireRate;
@property (assign, nonatomic) NSUInteger projectileSpeed;
@property (assign, nonatomic) NSUInteger damage;
@property (assign, nonatomic) NSUInteger upgradeCost;
+(instancetype)defaultTurret;
-(void)launchCarrots;
-(void)stopBullets;
@end

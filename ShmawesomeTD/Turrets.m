//
//  Turrets.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Turrets.h"
#import "Mobs.h"
#import "SKScene+UtilityFunctions.h"
@interface Turrets ()
-(BOOL)hasTarget;


@end
@implementation Turrets
+(instancetype)turretWithImageNamed:(NSString *)name {
    Turrets *turret = [super spriteNodeWithImageNamed:name];
    turret.name = @"defaultTurret";
    turret.zPosition = 5;
    return turret;
}

+(instancetype)blankTurretWithScreenWidth:(int)width{
    Turrets *turret = [super spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(width/10, width/10)];
    turret.name = @"blankTurret";
    turret.upgradeCost = 2000;
    return turret;
}

-(void)launchCarrots{
    SKAction *carrotSequence = [SKAction runBlock:^{
        SKSpriteNode *carrotz = [SKSpriteNode spriteNodeWithImageNamed:@"carrotMissile"];
        carrotz.position = CGPointMake(self.size.width/2, self.size.height/2);
        carrotz.name = @"carrot";
        carrotz.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:carrotz.frame.size];
        carrotz.physicsBody.dynamic = YES;
        carrotz.zPosition = 5;
        carrotz.physicsBody.categoryBitMask = kFiredBulletCategory;
        carrotz.physicsBody.contactTestBitMask = kInvaderCategory;
        carrotz.physicsBody.collisionBitMask = 0x0;
//        carrotz.physicsBody.usesPreciseCollisionDetection = YES;
        carrotz.physicsBody.affectedByGravity = NO;
        [self addChild:carrotz];
        SKAction *fire = [SKAction moveBy:CGVectorMake(0, 1000) duration:self.projectileSpeed];
        [carrotz runAction:fire completion:^{
            [carrotz removeFromParent];
        }];
    }];
    SKAction *wait = [SKAction waitForDuration:self.fireRate];
    SKAction *machineGun = [SKAction repeatActionForever:[SKAction sequence:@[carrotSequence,wait]]];
    [self runAction:machineGun];
}

-(BOOL)hasTarget{
//    [self.scene enumerateChildNodesWithName:@"defaultMobName" usingBlock:^(SKNode *node, BOOL *stop) {
       // if (abs((node.position.x - self.position.x))<=self.size.width)
    return YES;
}

-(void)stopBullets{
    [self removeAllActions];
}


+(instancetype)defaultTurret{
    Turrets *turret = [self turretWithImageNamed:@"lilturret"];
//    turret.anchorPoint = CGPointMake(turret.size.width/2, turret.size.height/2);
    turret.damage = 34;
//    turret.size = CGSizeMake(40, 50);
    turret.fireRate = 3.7;
    turret.projectileSpeed = 2.3;

    return turret;
}


@end

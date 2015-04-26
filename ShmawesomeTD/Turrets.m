//
//  Turrets.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Turrets.h"
#import "Mobs.h"


@implementation Turrets
+(instancetype)turretWithImageNamed:(NSString *)name{
    Turrets *turret = [super spriteNodeWithImageNamed:name];
    turret.name = @"defaultTurret";
    turret.zPosition = 4;

    return turret;
}




+(instancetype)defaultTurret{
    Turrets *turret = [self turretWithImageNamed:@"lilturret"];
//    turret.anchorPoint = CGPointMake(turret.size.width/2, turret.size.height/2);
    turret.damage = 34;
//    turret.size = CGSizeMake(40, 50);
    turret.fireRate = 4.7;
    turret.projectileSpeed = 2.3;
    turret.turretType = LightTurret;

    return turret;
}

-(void)fireCarrots{
    
    
    SKAction *carrotSequence = [SKAction runBlock:^{
        SKSpriteNode *carrotz = [SKSpriteNode spriteNodeWithImageNamed:@"carrotMissile"];
        carrotz.position = CGPointMake(self.position.x, self.position.y);
        carrotz.name = @"carrot";
        carrotz.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:carrotz.frame.size];
        carrotz.physicsBody.dynamic = YES;
        carrotz.physicsBody.categoryBitMask = kFiredBulletCategory;
        carrotz.physicsBody.contactTestBitMask = kInvaderCategory;
        carrotz.physicsBody.collisionBitMask = 0x0;
        carrotz.physicsBody.affectedByGravity = NO;
        [self addChild:carrotz];
        SKAction *fire = [SKAction moveToY:(self.scene.size.height + 100) duration:self.projectileSpeed];
        [carrotz runAction:fire];
    
    }];
    
    SKAction *wait = [SKAction waitForDuration:self.fireRate];
    SKAction *machineGun = [SKAction repeatActionForever:[SKAction sequence:@[carrotSequence,wait]]];
    [self runAction:machineGun];
            }


-(void)stopCarrots{
    [self.children enumerateObjectsUsingBlock:^(SKNode *carrot, NSUInteger idx, BOOL *stop) {
        if ([carrot.name isEqualToString:@"carrot"]){
            [carrot removeFromParent];
        }
    }];
    
}

@end

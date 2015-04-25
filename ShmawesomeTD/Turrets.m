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

+(instancetype)defaultTurret{
    Turrets *turret = [super spriteNodeWithImageNamed:@"lilturret"];
    turret.name = @"defaultTurret";
//    turret.anchorPoint = CGPointMake(turret.size.width/2, turret.size.height/2);
    turret.damage = 34;
//    turret.size = CGSizeMake(40, 50);
    turret.fireRate = 1.7;
    turret.projectileSpeed = 1.3;
    turret.turretType = LightTurret;
    turret.zPosition = 4;
    return turret;
}





@end

//
//  Turrets.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Turrets.h"


@implementation Turrets

+(instancetype)defaultTurret{
    Turrets *turret = [super spriteNodeWithImageNamed:@"lilturret"];
    turret.name = @"defaultMob";
//    turret.anchorPoint = CGPointZero;
    turret.damage = 34;
    turret.fireRate = 4.7;
    turret.turretType = LightTurret;
    turret.zPosition = 4;
    return turret;
}




@end

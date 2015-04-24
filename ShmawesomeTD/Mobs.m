//
//  Mobs.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Mobs.h"

@implementation Mobs
@synthesize delegate;

+(instancetype)defaultMob{
    Mobs *mob = [super spriteNodeWithImageNamed:@"pingstealth"];
    mob.name = @"defaultMob";
    mob.anchorPoint = CGPointZero;
    mob.mobHealth = 100;
    mob.mobSpeed = 4.7;
    mob.zPosition = 5;
    return mob;
}



-(void)setMobHealth:(NSUInteger)thing{
    if (thing > 0) {
        _mobHealth = thing;
    } else {
//        EXPLOSION!!! (switch sprite to exploision atlas. yay
        
        [self.delegate mobDeath];
    }
}

-(void)takeDamage:(NSUInteger)damage{
    if (!self.mobHealth) return;
    self.mobHealth -= damage;
}

@end



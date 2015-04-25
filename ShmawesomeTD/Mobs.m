//
//  Mobs.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Mobs.h"
@interface Mobs ()
@property (strong, nonatomic) SKTextureAtlas *tex;
@property (strong, nonatomic) NSMutableArray *explosion;


@end

@implementation Mobs
@synthesize delegate;

+(instancetype)defaultMob{
    Mobs *mob = [super spriteNodeWithImageNamed:@"harrier"];
    mob.name = @"defaultMob";
    mob.anchorPoint = CGPointZero;
    mob.mobHealth = 100;
    mob.mobSpeed = 4.7;
    mob.zPosition = 5;
    return mob;
}

+(instancetype)lightMob{
    Mobs *mob = [super spriteNodeWithImageNamed:@"superhornet"];
    mob.name = @"defaultMob";
    mob.anchorPoint = CGPointZero;
    mob.mobHealth = 100;
    mob.mobSpeed = 4.7;
    mob.zPosition = 5;
    return mob;
}

+(instancetype)mediumMob{
    Mobs *mob = [super spriteNodeWithImageNamed:@"fantom"];
    mob.name = @"defaultMob";
    mob.anchorPoint = CGPointZero;
    mob.mobHealth = 100;
    mob.mobSpeed = 4.7;
    mob.zPosition = 5;
    return mob;
}

+(instancetype)heavyMob{
    Mobs *mob = [super spriteNodeWithImageNamed:@"harrier"];
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
        [self explode];
    }
}

-(void)takeDamage:(NSUInteger)damage{
    if (!self.mobHealth) return;
    self.mobHealth -= damage;
}
-(void)explode{
     [self runAction:[SKAction animateWithTextures:self.explosion timePerFrame:0.1 resize:YES restore:NO]completion:^{
         [self removeFromParent];
     }];    
}


-(SKTextureAtlas *)tex{
    if (_tex) return _tex;
    _tex = [SKTextureAtlas atlasNamed:@"explosion"];
    return _tex;
}

-(NSMutableArray *)explosion{
    if (_explosion) return _explosion;
    _explosion = [NSMutableArray array];
    [self.tex.textureNames enumerateObjectsUsingBlock:^(NSString *boomName, NSUInteger idx, BOOL *stop) {
        [_explosion addObject:[self.tex textureNamed:boomName]];
        
    }];

    return _explosion;
}


@end



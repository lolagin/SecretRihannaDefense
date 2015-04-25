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
+(instancetype)mobWithImageNamed:(NSString *)name{
    Mobs *mob = [super spriteNodeWithImageNamed:name];
    mob.name = @"defaultMob";
    mob.anchorPoint = CGPointZero;
    mob.zPosition = 5;
    mob.physicsBody.dynamic = NO;
    mob.physicsBody.categoryBitMask = kInvaderCategory;
    mob.physicsBody.contactTestBitMask = 0x0;
    mob.physicsBody.collisionBitMask = 0x0;
    return mob;
}
+(instancetype)defaultMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"pingstealth"];
    mob.mobHealth = 100;
    mob.mobSpeed = 2.7;

    return mob;
}

+(instancetype)lightMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"superhornet"];
    mob.mobHealth = 100;
    mob.mobSpeed = 4.7;
    return mob;
}

+(instancetype)mediumMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"fantom"];
    mob.mobHealth = 100;
    mob.mobSpeed = 6.7;
    return mob;
}

+(instancetype)heavyMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"harrier"];
    mob.mobHealth = 100;
    mob.mobSpeed = 5.0;
    return mob;
}

+(instancetype)kanyeMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"kanyehead"];
    mob.mobHealth = 100;
    mob.mobSpeed = 2.0;
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



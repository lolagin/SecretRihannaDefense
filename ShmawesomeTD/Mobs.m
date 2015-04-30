//
//  Mobs.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/23/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "Mobs.h"
#import "SKScene+UtilityFunctions.h"


@interface Mobs ()
@property (strong, nonatomic) SKTextureAtlas *tex;
@property (strong, nonatomic) NSMutableArray *explosion;

@end
@implementation Mobs
@synthesize delegate;
+(instancetype)mobWithImageNamed:(NSString *)name{
    Mobs *mob = [super spriteNodeWithImageNamed:name];
//    mob.anchorPoint = CGPointZero;
    mob.zPosition = 5;
    mob.name = @"defaultMobName";
    mob.physicsBody.dynamic = YES;
    mob.physicsBody.categoryBitMask = kInvaderCategory;
    mob.physicsBody.contactTestBitMask = 0x0;
    mob.physicsBody.collisionBitMask = 0x0;
    mob.mobPointReward = 1000;
    return mob;
}
+(instancetype)defaultMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"pingstealth"];
//    mob.name = @"defaultMob";
    mob.mobHealth = 100;
    mob.mobSpeed = 3.7;
    return mob;
}

+(instancetype)lightMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"superhornet"];
//    mob.name = @"lightMob";
    mob.mobHealth = 100;
    mob.mobSpeed = 4.7;
    return mob;
}

+(instancetype)mediumMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"fantom"];
//    mob.name = @"mediumMob";
    mob.mobHealth = 100;
    mob.mobSpeed = 5.1;
    return mob;
}

+(instancetype)heavyMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"harrier"];
//    mob.name = @"heavyMob";
    mob.mobHealth = 100;
    mob.mobSpeed = 9.5;
    return mob;
}

+(instancetype)kanyeMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"kanyehead"];
    mob.mobHealth = 100;
    mob.mobSpeed = 2.0;
    return mob;
}
+(instancetype)bossMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"boss"];
    mob.mobHealth = 300;
    mob.mobSpeed = 10.7;
    
    return mob;
    
}


-(void)takeDamage:(NSUInteger)damage{
    if (damage >= self.mobHealth){
        [self explode];
        return;
    }
    self.mobHealth -= damage;
}

-(void)explode{
    [self.delegate mobDeathWithPoints:self.mobPointReward];
    [self removeAllActions];
    [self runAction:[SKAction animateWithTextures:self.explosion timePerFrame:0.05 resize:YES restore:NO]completion:^{
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
    if (self.tex){
        _explosion = [SKScene textureArrayFromAtlas:self.tex];
    }
    return _explosion;
}
@end



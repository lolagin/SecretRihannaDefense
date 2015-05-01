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
+(instancetype)mobWithImageNamed:(NSString *)name AndSpeed:(CGFloat)speed{
    Mobs *mob = [super spriteNodeWithImageNamed:name];
//    mob.anchorPoint = CGPointZero;
    mob.zPosition = 5;
    mob.name = @"defaultMobName";
    mob.physicsBody.dynamic = YES;
    mob.physicsBody.categoryBitMask = kInvaderCategory;
    mob.physicsBody.contactTestBitMask = 0x0;
    mob.physicsBody.collisionBitMask = 0x0;
    mob.mobSpeed = speed;
    mob.mobPointReward = 1000;
    SKAction *flight = [SKAction moveBy:CGVectorMake(0, -10) duration:mob.mobSpeed];
    [mob runAction:flight withKey:@"mobFlight"];
     
     
//        completion:^{
//        [mob removeFromParent];
//    }];

    return mob;
}
+(instancetype)defaultMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"pingstealth" AndSpeed:3.7];
//    mob.name = @"defaultMob";
    mob.mobHealth = 100;
    mob.mobSpeed = 3.7;
    return mob;
}

+(instancetype)lightMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"superhornet" AndSpeed:8.7];
//    mob.name = @"lightMob";
    mob.mobHealth = 100;
    return mob;
}

+(instancetype)mediumMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"fantom" AndSpeed:9.1];
//    mob.name = @"mediumMob";
    mob.mobHealth = 100;
    return mob;
}

+(instancetype)heavyMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"harrier" AndSpeed:9.5];
//    mob.name = @"heavyMob";
    mob.mobHealth = 100;
    return mob;
}

+(instancetype)kanyeMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"kanyehead" AndSpeed:9.0];
    mob.mobHealth = 100;
    return mob;
}
+(instancetype)bossMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"bosssprite" AndSpeed:25.7];
    mob.mobHealth = 300;
    NSMutableArray *freakz = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"boss"]];
    SKAction *anime = [SKAction animateWithTextures:freakz timePerFrame:0.1 resize:NO restore:NO];
    [mob runAction:[SKAction repeatActionForever:anime]];
    return mob;
    
}

+(instancetype)bobMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"bobsprite" AndSpeed:20.7];
    mob.mobHealth = 300;
    NSMutableArray *freakz = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"bob"]];
    SKAction *anime = [SKAction animateWithTextures:freakz timePerFrame:0.07 resize:NO restore:NO];
    [mob runAction:[SKAction repeatActionForever:anime]];
    return mob;
    
}

+(instancetype)patMob{
    Mobs *mob = [Mobs mobWithImageNamed:@"patsprite" AndSpeed:20.7];
    mob.mobHealth = 300;
    NSMutableArray *freakz = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"patrick2"]];
    SKAction *anime = [SKAction animateWithTextures:freakz timePerFrame:0.07 resize:NO restore:NO];
    [mob runAction:[SKAction repeatActionForever:anime]];
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
    [self removeActionForKey:@"mobFlight"];
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



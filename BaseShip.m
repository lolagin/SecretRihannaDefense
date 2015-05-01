//
//  BaseShip.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/28/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "BaseShip.h"
#import "Turrets.h"
#import "SKScene+UtilityFunctions.h"

@interface BaseShip ()
@property (assign, nonatomic)CGRect ancestralBounds;

@end

@implementation BaseShip
+(instancetype)BSWithSize:(int)width andImage:(NSString *)imageNamed{
    BaseShip *basic = [[BaseShip alloc] initWithTexture:[SKTexture textureWithImageNamed:imageNamed] color:[SKColor clearColor] size:CGSizeMake(width, width/3)];
    basic.anchorPoint = CGPointZero;
    return basic;
}

+(instancetype)defaultBaseWithWidth:(int)width{
    BaseShip *towerBase = [BaseShip BSWithSize:width andImage:@"towerBase"];
    towerBase.userInteractionEnabled = YES;
    for (int i = 0; i<5; i++) {
        [towerBase addChild:[Turrets defaultTurret]];
        ((SKNode *)[towerBase children][i]).position = CGPointMake((towerBase.size.width / 6) * (i+1), towerBase.size.height/3);
    }
    return towerBase;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"tooucehswerks");
    
}



@end

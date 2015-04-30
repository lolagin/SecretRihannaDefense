//
//  TurretStore.h
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/29/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class Turrets;
@interface TurretStore : SKSpriteNode
+(instancetype)storeWithOriginTurret:(Turrets *)turret AndContainerSize:(CGSize)size;
    

    




@end

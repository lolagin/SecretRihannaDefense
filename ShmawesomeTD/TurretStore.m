//
//  TurretStore.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/29/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "TurretStore.h"
@interface TurretStore ()

@property (strong, nonatomic)Turrets *activeTurret;
@property (strong, nonatomic)NSArray *turretOptions;
@property (assign, nonatomic)CGSize containerSize;

@end

@implementation TurretStore
+(instancetype)storeWithOriginTurret:(Turrets *)turret AndContainerSize:(CGSize)size{
    TurretStore *store = [TurretStore spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(size.width/3, size.height/3)];
    store.containerSize = size;
    store.activeTurret = turret;
    
    return store;
}


@end

//
//  SKSpriteNode+Animations.h
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const u_int32_t kInvaderCategory   = 0x1 << 0;
static const u_int32_t kSceneEdgeCategory = 0x1 << 1;
static const u_int32_t kFiredBulletCategory = 0x1 << 2;
typedef NS_ENUM(NSInteger, AnimationType) {
bullet,
mob
};
@interface SKSpriteNode (Animations)
+(NSMutableArray *)textureArrayFromAtlas:(SKTextureAtlas *)atlas;

@end

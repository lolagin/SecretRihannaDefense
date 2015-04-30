//
//  SKScene+UtilityFunctions.h
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


typedef NS_OPTIONS(NSUInteger, CollisionGameCategories) {
    kSceneEdgeCategory     = 0,
    kFiredBulletCategory    = 1 << 0,
    kInvaderCategory     = 1 << 1,
};

@interface NSString (AddedBonus)
-(void)speakString;
@end

@interface SKScene (UtilityFunctions)
-(void)bumpNodes:(SKSpriteNode *)nodeAlpha and:(SKSpriteNode *)nodeBeta;
+(NSMutableArray *)textureArrayFromAtlas:(SKTextureAtlas *)atlas;
+(SKEmitterNode *)emitterNodeWithEmitterNamed:(NSString *)emitterFileName;
@end

//
//  SKSpriteNode+Animations.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "SKSpriteNode+Animations.h"

@implementation SKSpriteNode (Animations)
+(NSMutableArray *)textureArrayFromAtlas:(SKTextureAtlas *)atlas{
    NSMutableArray *outputArray = [NSMutableArray array];
    NSMutableString *texString = [NSMutableString string];
    NSScanner *nameScanner = [[NSScanner alloc] initWithString:atlas.textureNames[0]];
    [nameScanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&texString];
    for (int i = 1; i <= [atlas.textureNames count]; i++){
        [outputArray addObject:[atlas textureNamed:[NSString stringWithFormat:@"%@%d.png",texString,i]]];

    }
    return outputArray;
}


-(void)randomIntervalEffects:(NSTimeInterval *)current{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"kanyehead"];
    
    
    
}

-(void)bumpNodes:(SKSpriteNode *)nodeAlpha and:(SKSpriteNode *)nodeBeta{
        nodeAlpha.position = CGPointMake(nodeAlpha.position.x, nodeAlpha.position.y-4);
        nodeBeta.position = CGPointMake(nodeBeta.position.x, nodeBeta.position.y-4);
        if (nodeAlpha.position.y < -nodeAlpha.size.height){
            nodeAlpha.position = CGPointMake(nodeAlpha.position.x, nodeBeta.position.y + nodeBeta.size.height);
        }
        if (nodeBeta.position.y < -nodeBeta.size.height) {
            nodeBeta.position = CGPointMake(nodeBeta.position.x, nodeAlpha.position.y + nodeAlpha.size.height);
        }
    }








@end

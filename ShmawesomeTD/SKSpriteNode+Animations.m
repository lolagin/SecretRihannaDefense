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
        NSLog(@"%@",[NSString stringWithFormat:@"%@%d.png",texString,i]);
        NSLog(@"%@",outputArray[i-1]);
    }
    return outputArray;
}

-(void)firebullet{
    self.position = CGPointMake(self.position.x, self.position.y+4);
}


-(void)runActions:(NSArray *)raze{
        [raze enumerateObjectsUsingBlock:^(SKSpriteNode *obj, NSUInteger idx, BOOL *stop) {
        [obj firebullet];
        }];
        }

    
    





@end

//
//  IntroScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/24/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "IntroScene.h"
#import "GameScene.h"
@interface IntroScene ()

@property (strong, nonatomic)SKSpriteNode *background;
@property (strong, nonatomic)SKLabelNode *labelGun;
@property (strong, nonatomic)SKTextureAtlas *tex;
@property (strong, nonatomic)NSMutableArray *introFlight;

@end
@implementation IntroScene
-(void)didMoveToView:(SKView *)view{

    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"intro"];
    self.background.size = self.frame.size;
    self.background.position = self.position;
    self.background.anchorPoint = self.anchorPoint;
    [self addChild:self.background];
    [self explode];
    
}


-(void)update:(NSTimeInterval)currentTime{
    
    
}



#pragma mark ||touches||
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
                if ([node isEqualToNode:self.background]) {
                    [self transitionScenes];
                    

                
                }
//              if ([node isKindOfClass:[Mobs class]]){
        
        
        
        
    }
}

-(void)transitionScenes{
    SKTransition *tranny = [SKTransition flipVerticalWithDuration:1.5];
    GameScene *gameScene = [[GameScene alloc] initWithSize:self.scene.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:gameScene transition:tranny];
}


-(void)explode{
    
    SKSpriteNode *sevenUp = [SKSpriteNode spriteNodeWithImageNamed:@"kanyeHead"];
    
                             
//                                               spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(self.size.width / 6, self.size.height / 6)];
    sevenUp.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:sevenUp];
    [sevenUp runAction:[SKAction animateWithTextures:self.introFlight timePerFrame:0.1 resize:YES restore:NO]completion:^{
        [sevenUp removeFromParent];
        [self addChild:self.labelGun];
    }];
}

-(SKLabelNode *)labelGun{
    if (_labelGun) return _labelGun;
    _labelGun = [SKLabelNode labelNodeWithText:@"SHMAWSOME TD THE FUCKING VIDEOGAME"];
    _labelGun.color = [SKColor blackColor];
    _labelGun.colorBlendFactor = 0.8;
    _labelGun.fontColor = [SKColor whiteColor];
    _labelGun.position = CGPointMake(self.size.width/2, self.size.height/2);



    
    
    return _labelGun;
}
-(SKTextureAtlas *)tex{
    if (_tex) return _tex;
    _tex = [SKTextureAtlas atlasNamed:@"introsprite"];
    return _tex;
}

-(NSMutableArray *)introFlight{
    if (_introFlight) return _introFlight;
    _introFlight = [NSMutableArray array];
    [self.tex.textureNames enumerateObjectsUsingBlock:^(NSString *boomName, NSUInteger idx, BOOL *stop) {
        [_introFlight addObject:[self.tex textureNamed:boomName]];
        
    }];
    
    return _introFlight;
}

@end

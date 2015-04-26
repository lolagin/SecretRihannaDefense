//
//  IntroScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/24/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "IntroScene.h"
#import "GameScene.h"
#import "SKSpriteNode+Animations.h"
@interface IntroScene ()


@property (assign, nonatomic)BOOL introHasRun;

@property (strong, nonatomic)SKSpriteNode *background;
@property (strong, nonatomic)SKLabelNode *labelGun;
@property (strong, nonatomic)SKTextureAtlas *tex;
@property (strong, nonatomic)SKTextureAtlas *boomTex;
@property (strong, nonatomic)NSMutableArray *introFlight;
@property (strong, nonatomic)SKAction *sequencedFlightAction;
@property (strong, nonatomic)SKSpriteNode *explosion;
@property (strong, nonatomic)SKSpriteNode *introSprite;
@end
@implementation IntroScene



-(void)didMoveToView:(SKView *)view{
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"intro"];
    self.background.size = self.frame.size;
    self.background.position = self.position;
    self.background.anchorPoint = self.anchorPoint;
    [self addChild:self.background];
    [self addChild:self.introSprite];
}


-(void)runTheIntro{
    self.introHasRun = YES;
    [self addChild:self.explosion];
    [self.introSprite runAction:self.sequencedFlightAction completion:^{
        [self.introSprite removeFromParent];
        [self addChild:self.labelGun];
    }];
}

#pragma mark ||touches||
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
                if ([node isEqualToNode:self.background] && !self.introHasRun) {
                    [self runTheIntro];
                    return;
                }
                if ([node isEqualToNode:self.labelGun]) {
                            [self transitionScenes];
                }
        }
    }


#pragma mark ||Laziez||

-(SKSpriteNode *)introSprite{
    if (_introSprite) return _introSprite;
    _introSprite = [SKSpriteNode spriteNodeWithImageNamed:@"kanyeHead"];
    _introSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    _introSprite.zPosition = 20;
    return _introSprite;
}

-(SKSpriteNode *)explosion {
    if (_explosion)return _explosion;
    _explosion = [SKSpriteNode spriteNodeWithImageNamed:@"kanyehead"];
    _explosion.position = CGPointMake(self.size.width/2, self.size.height/2);
    _explosion.zPosition = 10;
    SKAction *scale = [SKAction scaleTo:3 duration:1.0];
    SKAction *scaleTiny = [SKAction scaleTo:0.0 duration:2.0];
    SKAction *action = [SKAction group:@[scale,[SKAction animateWithTextures:[SKSpriteNode textureArrayFromAtlas:self.boomTex] timePerFrame:0.15 resize:YES restore:NO]]];
    
    [_explosion runAction:[SKAction sequence:@[action,[SKAction group:@[[action reversedAction],scaleTiny]]]] completion:^{
        [_explosion removeFromParent];
    }];
    return _explosion;
}

-(SKLabelNode *)labelGun{
    if (_labelGun) return _labelGun;
    _labelGun = [SKLabelNode labelNodeWithText:@"ZOMBOID AIRCRAFT TD"];
    _labelGun.color = [SKColor blackColor];
    _labelGun.colorBlendFactor = 0.1;
    _labelGun.fontColor = [SKColor whiteColor];
    _labelGun.position = CGPointMake(self.size.width/2, self.size.height/2);
    return _labelGun;
}
-(SKTextureAtlas *)tex{
    if (_tex) return _tex;
    _tex = [SKTextureAtlas atlasNamed:@"introsprite"];
    return _tex;
}

-(SKTextureAtlas *)boomTex{
    if (_boomTex) return _boomTex;
    _boomTex = [SKTextureAtlas atlasNamed:@"explosion"];
    return _boomTex;
}
-(NSMutableArray *)introFlight{
    if (_introFlight) return _introFlight;
    _introFlight = [NSMutableArray array];
    if (self.tex) {
        _introFlight = [SKSpriteNode textureArrayFromAtlas:self.tex];
        return _introFlight;
    }
    NSLog(@"what are you trying to pass in here?? (introflight is empty)");
        return _introFlight;
}

-(SKAction *)sequencedFlightAction{
    if (_sequencedFlightAction)return _sequencedFlightAction;
    SKAction *action = [SKAction animateWithTextures:self.introFlight timePerFrame:0.12 resize:YES restore:NO];
    SKAction *rotate = [SKAction sequence:@[[SKAction rotateToAngle:5.2 duration:0.8],[SKAction rotateByAngle:15 duration:1.9]]];
    SKAction *moveSequence = [SKAction sequence:@[[SKAction moveBy:CGVectorMake(100.0, -300.0) duration:0.6],[SKAction moveBy: CGVectorMake(-200, 300) duration:0.5],[SKAction group:@[rotate,[SKAction sequence:@[[SKAction moveBy:CGVectorMake(300, 300) duration:0.4],[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.5]]]]]]];
    SKAction *scale = [SKAction scaleBy:3.0 duration:1.0];
    SKAction *sequenced = [SKAction group:@[action,
                                            [SKAction sequence:@[scale,[SKAction group:@[moveSequence,rotate]],[scale reversedAction]]],
                                            ]];
    _sequencedFlightAction = sequenced;
    return _sequencedFlightAction;
}





#pragma mark ||transition||
-(void)transitionScenes{
    SKTransition *tranny = [SKTransition flipVerticalWithDuration:1.5];
    GameScene *gameScene = [[GameScene alloc] initWithSize:self.scene.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:gameScene transition:tranny];
}






@end











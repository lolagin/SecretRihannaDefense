//
//  IntroScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/24/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "IntroScene.h"
#import "GameScene.h"
//#import "SKSpriteNode+Animations.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "SKScene+UtilityFunctions.h"
#import "Hud.h"

@interface IntroScene ()

@property (assign, nonatomic)BOOL introHasRun;
@property (strong, nonatomic)SKSpriteNode *background;
@property (strong, nonatomic)SKSpriteNode *background2;
@property (strong, nonatomic)SKSpriteNode *background3;
@property (strong, nonatomic)SKLabelNode *labelGun;
@property (strong, nonatomic)SKTextureAtlas *tex;
@property (strong, nonatomic)SKTextureAtlas *boomTex;
@property (strong, nonatomic)NSMutableArray *introFlight;
@property (strong, nonatomic)SKAction *sequencedFlightAction;
@property (strong, nonatomic)SKSpriteNode *explosion;
@property (strong, nonatomic)SKSpriteNode *introSprite;
@property (strong, nonatomic)SKEmitterNode *sparkleEmitter;
@property (strong, nonatomic)SKAction *introTransport;
@property (strong, nonatomic)SKAction *pathFinder;
@property (assign, nonatomic)NSUInteger bgCount;
@property (strong, nonatomic)AVAudioPlayer *player;

@end
@implementation IntroScene

-(AVAudioPlayer *)player{
    if (_player) return _player;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lean2.caf", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _player.numberOfLoops = -1;
    if (!_player){
        NSLog([error localizedDescription]);
        return nil;
    }
    return _player;
}
-(void)switchBackground{
    self.background2.alpha = 1.0;
    [self addChild:self.background2];
    self.background.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"lultum%lu",(unsigned long)self.bgCount]];
    [self.background2 runAction:[SKAction fadeOutWithDuration:2.0]completion:^{
        [self.background2 removeFromParent];
        self.background2.texture = self.background.texture;
        self.bgCount++;
        [self switchBackground];
    }];
}



-(void)didMoveToView:(SKView *)view{
    self.background = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:self.frame.size];
    self.background.position = CGPointMake(self.size.width/2, self.size.height/2);
    self.background.zPosition = 10;
    self.background2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:self.background.size];
    self.background2.zPosition = 11;
    self.background2.position = CGPointMake(self.size.width/2, self.size.height/2);
    self.background3 = [SKSpriteNode spriteNodeWithImageNamed:@"intro"];
    self.background3.size = CGSizeMake(self.size.width * 1.5, self.size.height * 1.5);
    self.background3.position = CGPointMake(self.size.width/2, self.size.height/2);
    self.background3.alpha=0.8;
    self.background3.zPosition = 20;
    [self.player play];
    //    self.background.anchorPoint = self.anchorPoint;
    [self addChild:self.background];
    [self addChild:self.background3];
    [self addChild:self.introSprite];
    [self switchBackground];
//    [self addChild:[Hud defaultHud]];
//    [self runAction:self.introTransport];
//        [self runAction:self.pathFinder];
}


-(void)runTheIntro{
    self.introHasRun = YES;
    [self addChild:self.explosion];
    [self.introSprite runAction:self.sequencedFlightAction completion:^{
        [self.introSprite removeFromParent];
        self.labelGun.text = @"CLICK HERE TO START";
        NSString *string = [NSString stringWithString:self.labelGun.text];
        [string speakString];
        [self addChild:self.labelGun];
    }];
}

#pragma mark ||touches||
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        [self addChild:self.sparkleEmitter];
        self.sparkleEmitter.position = location;
                if ([node isEqualToNode:self.background3] && !self.introHasRun) {
                    [self runTheIntro];
                    return;
                }
                if ([node isEqualToNode:self.introSprite]) {
                            [self transitionScenes];
                    return;
                }
                if ([node isEqualToNode:self.labelGun]) {
                            [self transitionScenes];
                }
        }
    }

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        self.sparkleEmitter.position = location;
}
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.sparkleEmitter removeFromParent];
}





#pragma mark ||transition||
-(void)transitionScenes{
    [self.player stop];
    SKTransition *tranny = [SKTransition flipVerticalWithDuration:1.5];
    GameScene *gameScene = [[GameScene alloc]initWithSize:self.scene.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:gameScene transition:tranny];
}



#pragma mark ||Laziez||

-(SKEmitterNode *)sparkleEmitter{
    if (_sparkleEmitter) return _sparkleEmitter;
    _sparkleEmitter = [SKScene emitterNodeWithEmitterNamed:@"Damage"];
    _sparkleEmitter.paused = YES;
    _sparkleEmitter.zPosition = 20;
    return _sparkleEmitter;
    
    
}



-(SKSpriteNode *)introSprite{
    if (_introSprite) return _introSprite;
    _introSprite = [SKSpriteNode spriteNodeWithImageNamed:@"hankpimp"];
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
    SKAction *action = [SKAction group:@[scale,[SKAction animateWithTextures:[SKScene textureArrayFromAtlas:self.boomTex] timePerFrame:0.15 resize:YES restore:NO]]];
    
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
    _labelGun.zPosition = 21;
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
    _boomTex = [SKTextureAtlas atlasNamed:@"boom2"];
    return _boomTex;
}
-(NSMutableArray *)introFlight{
    if (_introFlight) return _introFlight;
    _introFlight = [NSMutableArray array];
    if (self.tex) {
        _introFlight = [SKScene textureArrayFromAtlas:self.tex];
        return _introFlight;
    }
    NSLog(@"what are you trying to pass in here?? (introflight is empty)");
        return _introFlight;
}

-(SKAction *)sequencedFlightAction{
    if (_sequencedFlightAction)return _sequencedFlightAction;
    SKAction *action = [SKAction animateWithTextures:self.introFlight timePerFrame:0.12 resize:YES restore:NO];
    
    SKAction *rotate = [SKAction sequence:@[[SKAction rotateToAngle:5.2 duration:0.8],[SKAction rotateByAngle:15 duration:1.9]]];
    SKAction *moveSequence = [SKAction sequence:@[
                                                  [SKAction moveBy:CGVectorMake(100.0, -300.0) duration:0.6],
                                                  [SKAction  moveBy: CGVectorMake(-200, 300) duration:0.5],
                                                  [SKAction group:@[
                                                                    rotate,
                                                                    [SKAction sequence:@[
                                                                                         [SKAction moveBy:CGVectorMake(300, 300) duration:0.4],
                                                                                         [SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/2) duration:0.5]]]]]]];
    SKAction *scale = [SKAction scaleBy:3.0 duration:1.0];
    SKAction *sequenced = [SKAction group:@[action,
                                            [SKAction sequence:@[scale,[SKAction group:@[moveSequence,rotate]],[scale reversedAction]]],
                                            ]];
//        [self runAction:self.introTransport];
            [self runAction:self.pathFinder];

    _sequencedFlightAction = sequenced;
    return _sequencedFlightAction;
}




-(NSUInteger)bgCount{
    if (_bgCount >= 8||_bgCount == 0) _bgCount = 1;
    if (!_bgCount) _bgCount = 1;
    return _bgCount;
}

-(SKAction *)pathFinder{
    if (_pathFinder) return _pathFinder;
//    CGRect frame = [[UIScreen  mainScreen] nativeBounds];
    CGRect frame = self.frame;
    CGMutablePathRef pathie = CGPathCreateMutable();
    CGPathMoveToPoint(pathie, NULL, frame.size.width/2, frame.size.height/2);
    CGPathAddQuadCurveToPoint(pathie, NULL, CGRectGetMaxX(frame), CGRectGetMaxY(frame), CGRectGetMinX(frame), CGRectGetMaxY(frame));
    CGPathAddQuadCurveToPoint(pathie, NULL, CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetMaxX(frame), CGRectGetMinY(frame));
    CGPathAddQuadCurveToPoint(pathie, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame), CGRectGetMinX(frame), CGRectGetMinY(frame));
    CGPathAddQuadCurveToPoint(pathie, NULL, CGRectGetMinX(frame), CGRectGetMaxY(frame), CGRectGetMidX(frame), CGRectGetMidY(frame));
    SKAction *blacktion = [SKAction runBlock:^{
        SKSpriteNode *spritz = [SKSpriteNode spriteNodeWithImageNamed:@"gibsonface"];
        spritz.position = CGPointMake((self.size.width/2), self.size.height/2);
        spritz.size = CGSizeMake(100, 100);
        spritz.zPosition = 20;
        NSMutableArray *freakz = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"transport"]];
        SKAction *anime = [SKAction animateWithTextures:freakz timePerFrame:0.1 resize:YES restore:NO];
        NSMutableArray *freakz2 = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"boom3"]];
        SKAction *animeBoom = [SKAction animateWithTextures:freakz2 timePerFrame:0.1 resize:YES restore:NO];
        SKAction *vecz = [SKAction followPath:pathie asOffset:NO orientToPath:NO duration:3.1];
        SKAction *wait = [SKAction waitForDuration:1.0];
        [spritz runAction:[SKAction sequence:@[wait,anime,vecz,[anime reversedAction],animeBoom]] completion:^{
            [spritz removeFromParent];
        }];
        [self addChild:spritz];
    }];
    return blacktion;
    
}
-(SKAction *)introTransport{
    if (_introTransport) return _introTransport;
    SKAction *blacktion = [SKAction runBlock:^{
        SKSpriteNode *spritz = [SKSpriteNode spriteNodeWithImageNamed:@"kimsprite"];
        spritz.position = CGPointMake((self.size.width/3)*2, self.size.height/2);
        spritz.size = CGSizeMake(100, 100);
        NSMutableArray *freakz = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"transport"]];
        SKAction *anime = [SKAction animateWithTextures:freakz timePerFrame:0.1 resize:YES restore:NO];
        SKAction *vecz = [SKAction moveBy:CGVectorMake(-300, 400) duration:1.0];
        SKAction *wait = [SKAction waitForDuration:1.0];
        [spritz runAction:[SKAction sequence:@[wait,anime,vecz]] completion:^{
            [spritz removeFromParent];
        }];
        [self addChild:spritz];
    }];
    return blacktion;
}







@end











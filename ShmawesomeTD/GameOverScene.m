//
//  GameOverScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/29/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//
#import <AVFoundation/AVAudioPlayer.h>
#import "GameOverScene.h"
#import "SKScene+UtilityFunctions.h"
#import "IntroScene.h"
@interface GameOverScene ()
@property (assign, nonatomic)NSUInteger bgCount;
@property (assign, nonatomic)NSUInteger playerScore;
@property (assign, nonatomic)NSUInteger playerLevel;
@property (strong, nonatomic)SKSpriteNode *background;
@property (strong, nonatomic)SKSpriteNode *background2;
@property (strong, nonatomic)SKSpriteNode *background3;
@property (strong, nonatomic)SKSpriteNode *endSprite;
@property (strong, nonatomic)SKAction *patrickActionStar;
@property (strong, nonatomic)AVAudioPlayer *player;

@end
@implementation GameOverScene
-(AVAudioPlayer *)player{
    if (_player) return _player;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lean1.caf", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _player.numberOfLoops = -1;
    if (!_player){
        NSLog([error localizedDescription]);
        return nil;
    }
    return _player;
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

    [self addChild:self.background];
    [self addChild:self.background3];
    [self switchBackground];

    
    
    [self.player play];

    SKLabelNode *lebul = [SKLabelNode labelNodeWithText:@"nicely done buddeh you got points"];
    lebul.position = CGPointMake(self.size.width/2,self.size.height/2);
    [self runAction:self.patrickActionStar];
}


-(void)transitionScenes{
    SKTransition *tranny = [SKTransition flipVerticalWithDuration:1.5];
    IntroScene *introScene = [[IntroScene alloc] initWithSize:self.scene.size];
    introScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.player stop];
    [self.scene.view presentScene:introScene transition:tranny];
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


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if ([node isEqualToNode:self.endSprite]) {
            [self transitionScenes];
            return;
            }
        }
    }

-(NSUInteger)bgCount{
    if (_bgCount >= 8||_bgCount == 0) _bgCount = 1;
    if (!_bgCount) _bgCount = 1;
    return _bgCount;
}

-(SKSpriteNode *)endSprite{
    if (_endSprite)return _endSprite;
    _endSprite = [SKSpriteNode spriteNodeWithImageNamed:@"nikkibust"];
    _endSprite.zPosition = 30;
    _endSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    _endSprite.size = CGSizeMake(self.size.width/4, self.size.width/4);
    return _endSprite;
    
}
-(SKAction *)patrickActionStar{
    if (_patrickActionStar) return _patrickActionStar;
    SKAction *blacktion = [SKAction runBlock:^{
        SKSpriteNode *spritz = [SKSpriteNode spriteNodeWithImageNamed:@"nikkibust"];
        spritz.position = CGPointMake((self.size.width/3)*2, self.size.height/2);
        spritz.zPosition = 30;
        spritz.size = CGSizeMake(100, 100);
        NSMutableArray *freakz = [SKScene textureArrayFromAtlas:[SKTextureAtlas atlasNamed:@"patrick"]];
        SKAction *anime = [SKAction animateWithTextures:freakz timePerFrame:0.1 resize:YES restore:NO];
        SKAction *vecz = [SKAction moveBy:CGVectorMake(-300, 400) duration:1.0];
        SKAction *wait = [SKAction waitForDuration:1.0];
        CGMutablePathRef pathie = CGPathCreateMutable();
        CGPathMoveToPoint(pathie, NULL, self.frame.size.width/2, self.frame.size.height/2);
        CGPathAddEllipseInRect(pathie, NULL, CGRectInset(self.frame, -100, -200));
        SKAction *circles = [SKAction followPath:pathie duration:1.9];
        
        [spritz runAction:[SKAction sequence:@[wait,[SKAction group:@[circles, anime]],vecz]] completion:^{
            [spritz removeFromParent];
            [self addChild:self.endSprite];
        }];
        [self addChild:spritz];
    }];
    return blacktion;
}

@end

//
//  GameOverScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/29/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "GameOverScene.h"
#import "SKScene+UtilityFunctions.h"
#import "IntroScene.h"
@interface GameOverScene ()
@property (assign, nonatomic)NSUInteger playerScore;
@property (assign, nonatomic)NSUInteger playerLevel;
@property (strong, nonatomic)SKSpriteNode *background;
@property (strong, nonatomic)SKSpriteNode *endSprite;
@property (strong, nonatomic)SKAction *patrickActionStar;
@end
@implementation GameOverScene

-(void)didMoveToView:(SKView *)view{
    self.background = [SKSpriteNode spriteNodeWithImageNamed:@"intro"];
    self.background.size = self.frame.size;
    self.background.position = CGPointMake(self.size.width/2, self.size.height/2);
    //    self.background.anchorPoint = self.anchorPodint;
    [self addChild:self.background];
    SKLabelNode *lebul = [SKLabelNode labelNodeWithText:@"nicely done buddeh you got points"];
    lebul.position = CGPointMake(self.size.width/2,self.size.height/2);
    [self runAction:self.patrickActionStar];
}


-(void)transitionScenes{
    SKTransition *tranny = [SKTransition flipVerticalWithDuration:1.5];
    IntroScene *introScene = [[IntroScene alloc] initWithSize:self.scene.size];
    introScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:introScene transition:tranny];
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
-(SKSpriteNode *)endSprite{
    if (_endSprite)return _endSprite;
    _endSprite = [SKSpriteNode spriteNodeWithImageNamed:@"jobshead"];
    _endSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    _endSprite.size = CGSizeMake(self.size.width/4, self.size.width/4);
    return _endSprite;
    
}
-(SKAction *)patrickActionStar{
    if (_patrickActionStar) return _patrickActionStar;
    SKAction *blacktion = [SKAction runBlock:^{
        SKSpriteNode *spritz = [SKSpriteNode spriteNodeWithImageNamed:@"jobshead"];
        spritz.position = CGPointMake((self.size.width/3)*2, self.size.height/2);
        spritz.zPosition = 20;
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

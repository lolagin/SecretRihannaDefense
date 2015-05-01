//
//  IntroIntroScene.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/30/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//
#import <AVFoundation/AVAudioPlayer.h>
#import "IntroIntroScene.h"
#import "IntroScene.h"
#import "SWScrollView.h"
#import "SKScene+UtilityFunctions.h"

@interface IntroIntroScene ()
@property (strong, nonatomic)AVAudioPlayer *player;
@end
@implementation IntroIntroScene

-(AVAudioPlayer *)player{
    if (_player) return _player;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/starwars.caf", [[NSBundle mainBundle] resourcePath]]];
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
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:self.size];
    bg.position = CGPointMake(self.size.width/2, self.size.height/2);
    CGPoint scrollStartPoint = CGPointMake(0, -100);
    SWScrollView *scrollView = [SWScrollView scrollViewWithStartPoint:scrollStartPoint];
    [self addChild:bg];
    [self.view addSubview:scrollView];
        [self.player play];
    [scrollView startAnimationWithDuration:6.f completion:^(BOOL finished) {
        [self.player stop];
        [scrollView removeFromSuperview];
        [self transitionScenes];
        
    }];
}


-(void)transitionScenes{
    SKTransition *tranny = [SKTransition doorsOpenHorizontalWithDuration:1.5];
    IntroScene *introScene = [[IntroScene alloc]initWithSize:self.scene.size];
    introScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:introScene transition:tranny];
}

@end

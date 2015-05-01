//
//  SKScene+UtilityFunctions.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/26/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "SKScene+UtilityFunctions.h"
#import <AVFoundation/AVFoundation.h>
@implementation NSString (AddedBonus)



-(void)speakString{
AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self];
utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.rate = 0.15;
    AVSpeechSynthesizer *syn = [[AVSpeechSynthesizer alloc] init];
    [syn pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
[syn speakUtterance:utterance];

}

@end


@interface SKScene ()
@end
@implementation SKScene (UtilityFunctions)

+(AVAudioPlayer *)playerWithAudio:(NSString *)audio{
    NSError *error;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.caf",audio,[[NSBundle mainBundle] resourcePath]]];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    player.numberOfLoops = -1;
    return player;    
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

+ (SKEmitterNode *)emitterNodeWithEmitterNamed:(NSString *)emitterFileName {
SKEmitterNode *node = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:emitterFileName ofType:@"sks"]];

    return node;
    
// EX:   [SKEmitterNode apa_emitterNodeWithEmitterNamed:@"Damage"]

}


@end

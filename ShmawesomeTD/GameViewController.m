//
//  GameViewController.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/22/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "IntroScene.h"
#import "IntroViewController.h"


@interface GameViewController ()
@property (strong, nonatomic)NSTimer *scrollingTimer;
@property (strong, nonatomic)UITextView *scrollingTextView;
@end

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidBecomeActive:)  name:UIApplicationDidBecomeActiveNotification  object:nil];

    
    // Configure the view.
    
    
    [self beginIntroScene];
   
}


- (void) autoscrollTimerFired
{
    
    CGPoint scrollPoint = self.scrollingTextView.contentOffset;
    scrollPoint.y = scrollPoint.y+10;
    [self.scrollingTextView setContentOffset:scrollPoint animated:YES];
//    CGPoint scrollPoint = self.scrollingTextView.contentOffset; // initial and after update
//    NSLog(@"%.2f %.2f",scrollPoint.x,scrollPoint.y);
//    if (scrollPoint.y == 583) // to stop at specific position
//    {
//        [self.scrollingTimer invalidate];
//        self.scrollingTimer = nil;
//    }
//    scrollPoint = CGPointMake(scrollPoint.x, scrollPoint.y + 1); // makes scroll
//    [self.scrollingTextView setContentOffset:scrollPoint animated:NO];
//    NSLog(@"%f %f",self.scrollingTextView.contentSize.width , self.scrollingTextView.contentSize.height);
//    
}

-(void)starWars{
    
    
    UIView *BGView = [[UIView alloc]initWithFrame:self.view.frame];
    BGView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:BGView];
    [self.view addSubview:self.scrollingTextView];
    if (self.scrollingTimer == nil){
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(0.06)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
}


-(void)beginIntroScene{
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    // Create and configure the scene.
    IntroScene *scene = [IntroScene unarchiveFromFile:@"IntroScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [skView presentScene:scene];
    
}

-(void)beginGameplay{
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [skView presentScene:scene];
    
    
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)handleApplicationWillResignActive:(NSNotification*)note
{
    ((SKView*)self.view).paused = YES;
}

- (void)handleApplicationDidBecomeActive:(NSNotification*)note
{
    ((SKView*)self.view).paused = NO;
}


@end

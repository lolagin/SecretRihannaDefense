//
//  IntroViewController.m
//  ShmawesomeTD
//
//  Created by Jeffrey C Rosenthal on 4/29/15.
//  Copyright (c) 2015 Jeffreycorp. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()
@property (weak, nonatomic) IBOutlet UITextView *scrollingTextView;
@property (strong, nonatomic)NSTimer *scrollingTimer;


@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    if (self.scrollingTimer == nil){
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(0.06)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) autoscrollTimerFired
{
    CGPoint scrollPoint = self.scrollingTextView.contentOffset;
    scrollPoint.y = scrollPoint.y+10;
    NSLog(@"working");
    [self.scrollingTextView setContentOffset:scrollPoint animated:YES];
}
-(UITextView *)scrollingTextView{
    if (_scrollingTextView) return _scrollingTextView;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(self.view.bounds, 32.0, 32.0)];
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    // Start with a blank transform
    CATransform3D blankTransform = CATransform3DIdentity;
    
    // Skew the text
    blankTransform.m34 = -1.0 / 500.0;
    
    // Rotate the text
    
    blankTransform = CATransform3DRotate(blankTransform, 45.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    
    // Set the transform
    [textView.layer setTransform:blankTransform];
    
    
    return textView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

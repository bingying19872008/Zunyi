//
//  ViewController.m
//  zunyi
//
//  Created by mac on 14-6-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AreaViewController.h"

@interface ViewController ()
{
    UIButton *lastMenuButton;
    __weak IBOutlet UIView *menubar;
    bool bhidemenubar;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    lastMenuButton = nil;
    bhidemenubar = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeScreen:(UIViewController *)viewOld toViewController:(UIViewController*)newView
{
    /*
     CATransition *animation = [CATransition animation];
     animation.delegate = self;
     animation.duration = 1.0;
     animation.timingFunction = UIViewAnimationCurveEaseInOut;
     animation.type = kCATransitionFade;
     animation.subtype = kCATransitionFromRight;;
     */
    
    CATransition *animation=[CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:1.75];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    
    [animation setFillMode:kCAFillModeRemoved];
    animation.endProgress=0.99;
    [self.view.layer addAnimation:animation forKey:nil];
    [self cycleFromViewController:viewOld toViewController:newView];
}

- (IBAction)menuclicked:(UIButton *)sender {
    if (lastMenuButton == sender) {
        return;
    }
    
    if (lastMenuButton == nil) {
        lastMenuButton = sender;
    }
    else
    {
        [lastMenuButton setImage:nil forState:UIControlStateNormal];
        lastMenuButton = sender;
    }
    
    [lastMenuButton setImage:[UIImage imageNamed:@"menuselected.png"] forState:UIControlStateNormal];
    
    //根据id执行操作
    UIViewController* newController = nil;
    UIViewController *viewTmp = [self.childViewControllers objectAtIndex:0];
    switch (sender.tag) {
        case 0://area
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"AreaView"];
            break;
            
        default:
            break;
    }
    if (newController == nil) {
        return;
    }
    [self changeScreen:viewTmp toViewController:newController];
}

- (IBAction)logoclicked:(UIButton *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0f];
    if (!bhidemenubar) {
        [menubar setFrame:CGRectMake(0, 754, 1024, 66)];
    }
    else
    {
        [menubar setFrame:CGRectMake(0, 702, 1024, 66)];
    }
    [UIView commitAnimations];
    bhidemenubar = !bhidemenubar;
}

- (void) cycleFromViewController: (UIViewController*) oldC
                toViewController: (UIViewController*) newC
{
    [oldC willMoveToParentViewController:nil];                        // 1
    [self addChildViewController:newC];
    
    CGRect newFrame = self.view.frame; //新加的view 在父视图中的位置
    newFrame.origin.x = 0;
    newFrame.origin.y = 0;
    [newC.view setFrame:newFrame];
    
    [self transitionFromViewController: oldC toViewController: newC   // 3
                              duration: 1 options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                // [containerView addSubview:newC.view];
                            }
                            completion:^(BOOL finished) {
                                [oldC removeFromParentViewController];
                                [oldC.view removeFromSuperview];// 5
                                [newC didMoveToParentViewController:self];
                            }];
}

@end

//
//  MainSceneViewController.m
//  zunyi
//
//  Created by mac on 14-6-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MainSceneViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MainSceneViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lighteffect1;
@property (weak, nonatomic) IBOutlet UIImageView *lighteffect2;

@end

@implementation MainSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //CoreAnimation 中坐标原点在左上角,QuartZ在左下 这里我们用的是CoreAnimation
    //由于我们修改了中心点实际会导致图像平移,从0.5,0.5移到 0.0,1.0(往右上角移动,这里的移动又是按照QuartZ来的)
    //所以必须重新计算position才会有效
    CALayer *layer = [_lighteffect1 layer];
    CGPoint oldAnchorPoint =  _lighteffect1.layer.anchorPoint;
    [_lighteffect1.layer setAnchorPoint:CGPointMake(0.0, 1.0)];
     [layer setPosition:CGPointMake(layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x), layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y))];
    float rotateAngle = -M_PI / 4;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:rotateAngle];
    rotationAnimation.duration = 2.0;
 //   rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.autoreverses = YES;
    [_lighteffect1.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //------
    CALayer *layer2 = [_lighteffect2 layer];
    CGPoint oldAnchorPoint2 =  _lighteffect2.layer.anchorPoint;
    [_lighteffect2.layer setAnchorPoint:CGPointMake(0.9, 1.0)];
    [layer2 setPosition:CGPointMake(layer2.position.x + layer2.bounds.size.width * (layer2.anchorPoint.x - oldAnchorPoint2.x), layer2.position.y + layer2.bounds.size.height * (layer2.anchorPoint.y - oldAnchorPoint2.y))];
    float rotateAngle2 = M_PI / 4;
    CABasicAnimation* rotationAnimation2;
    rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:rotateAngle2];
    rotationAnimation2.duration = 2.0;
    //   rotationAnimation.cumulative = YES;
    rotationAnimation2.repeatCount = HUGE_VALF;
    rotationAnimation2.autoreverses = YES;
    [_lighteffect2.layer addAnimation:rotationAnimation2 forKey:@"rotationAnimation"];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"11");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

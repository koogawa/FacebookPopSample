//
//  ViewController.m
//  POPSample
//
//  Created by 小川　航佑 on 2014/05/09.
//  Copyright (c) 2014年 Kosuke Ogawa. All rights reserved.
//

#import "ViewController.h"
#import "pop/pop.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *_view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _view = [[UIImageView alloc] initWithFrame:CGRectMake(120, 120, 80, 80)];
    _view.image = [UIImage imageNamed:@"marimo"];
    
    [self.view addSubview:_view];
    
    // タップに反応させる
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation1)]];
    
    // ドラッグに反応させる
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation4:)]];
}

// ぶよぶよ膨らむまりも
- (void)startAnimation1
{
    [_view pop_removeAllAnimations];
    _view.frame = CGRectMake(120, 120, 80, 80);
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(140, 140)];
    
    animation.springBounciness = 44.0f;
    animation.springSpeed = 6.0f;
    
    [_view pop_addAnimation:animation forKey:@"spring"];
}

// 高速に移動するまりも
- (void)startAnimation2
{
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPosition];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 300)];
    
    [_view pop_addAnimation:animation forKey:@"decay"];
}

// 回転するまりも
- (void)startAnimation3:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    spring.velocity = [NSValue valueWithCGPoint:velocity];
    
    [_view.layer pop_addAnimation:spring forKey:@"rotationAnimation"];
}

// 引っ張られるまりも
- (void)startAnimation4:(UIPanGestureRecognizer *)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    positionAnimation.dynamicsTension = 5;
    positionAnimation.dynamicsFriction = 5.0f;
    positionAnimation.springBounciness = 20.0f;
    [_view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    
    POPSpringAnimation *sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    sizeAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    sizeAnimation.springBounciness = 1.0f;
    sizeAnimation.dynamicsFriction = 1.0f;
    [_view.layer pop_addAnimation:sizeAnimation forKey:@"sizeAnimation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

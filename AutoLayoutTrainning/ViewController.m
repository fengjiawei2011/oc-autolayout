//
//  ViewController.m
//  AutoLayoutTrainning
//
//  Created by Feng, Jiawei on 7/10/16.
//  Copyright © 2016 Autolayout Trainning. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *topNav;
@property (nonatomic, strong) UIView *subNavRed;
@property (nonatomic, strong) UIView *subNavYellow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
//    [self example_1];
    
    [self example_3];
}


- (void) initTopNav {
    self.topNav = [UIView new];
    self.topNav.translatesAutoresizingMaskIntoConstraints = NO;
    self.topNav.backgroundColor = [UIColor blueColor];
}

- (void) initSubNavRed {
    self.subNavRed = [UIView new];
    self.subNavRed.translatesAutoresizingMaskIntoConstraints = NO;
    self.subNavRed.backgroundColor = [UIColor redColor];
}

- (void) initSubNavYellow {
    self.subNavYellow = [UIView new];
    self.subNavYellow.translatesAutoresizingMaskIntoConstraints = NO;
    self.subNavYellow.backgroundColor = [UIColor yellowColor];
}

-(void)addContraintsTo:(UIView *)view
          visualFormat:(NSString *)format{
    NSMutableDictionary *views = [[NSMutableDictionary alloc] initWithCapacity:3];
    if(_topNav && ![views objectForKey:@"_topNav"]) {
        [views setObject:_topNav forKey:@"_topNav"];
    }
    if(_subNavRed && ![views objectForKey:@"_subNavRed"]){
        [views setObject:_subNavRed forKey:@"_subNavRed"];
    }
    if(_subNavYellow && ![views objectForKey:@"_subNavYellow"]) {
        [views setObject:_subNavYellow forKey:@"_subNavYellow"];
    }
    
    NSArray *constraint = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                                        options:0
                                                                        metrics:nil
                                                                        views:views];
    [view addConstraints:constraint];
}


// play around with one view
- (void) example_1 {
    
    [self initTopNav];
    
    // Size constraints are added to a view itself
    [self addContraintsTo:self.topNav visualFormat:@"H:[_topNav(100)]"];
    [self addContraintsTo:self.topNav visualFormat:@"V:[_topNav(200)]"];
    
    // position contraints are added to the parent of a view
    [self addContraintsTo:self.view visualFormat:@"H:|-20-[_topNav]"];
    [self addContraintsTo:self.view visualFormat:@"V:|-20-[_topNav]"];
    
    [self.view addSubview:self.topNav];
}

//play around with two views
- (void) example_2 {
    
    [self initSubNavRed];
    [self initSubNavYellow];
    
    [self.view addSubview:self.subNavRed];
    [self.view addSubview:self.subNavYellow];
    
    [self addContraintsTo:self.subNavRed visualFormat:@"H:[_subNavRed(100)]"];
    [self addContraintsTo:self.subNavRed visualFormat:@"V:[_subNavRed(100)]"];
    
    [self addContraintsTo:self.subNavYellow visualFormat:@"H:[_subNavYellow(100)]"];
    [self addContraintsTo:self.subNavYellow visualFormat:@"V:[_subNavYellow(100)]"];
    
    [self addContraintsTo:self.view visualFormat:@"H:|-20-[_subNavRed]"];
    [self addContraintsTo:self.view visualFormat:@"V:|-20-[_subNavRed]"];
    
    [self addContraintsTo:self.view visualFormat:@"V:[_subNavRed]-20-[_subNavYellow]"];
    [self addContraintsTo:self.view visualFormat:@"H:|-20-[_subNavYellow]"];
    
    
}

//play around with three views
- (void) example_3 {
    [self initTopNav];
    [self initSubNavRed];
    [self initSubNavYellow];
    
    // must add sub view first, otherwise adding contraints will fail if having
    // relationship between super and sub view
    [self.view addSubview:_topNav];
    [_topNav addSubview:_subNavRed];
    [_topNav addSubview:_subNavYellow];
    
    [self addContraintsTo:_topNav visualFormat:@"V:[_topNav(100)]"];
    
    [self addContraintsTo:self.view visualFormat:@"V:|-0-[_topNav]"];
    [self addContraintsTo:self.view visualFormat:@"H:|-0-[_topNav]-0-|"];
    
    [self addContraintsTo:_topNav visualFormat:@"V:[_subNavRed(50)]"];
    [self addContraintsTo:_topNav visualFormat:@"V:|-0-[_subNavRed]"];
    [self addContraintsTo:_topNav visualFormat:@"H:|-0-[_subNavRed]-0-|"];
    
    [self addContraintsTo:_topNav visualFormat:@"V:[_subNavYellow(50)]"];
    [self addContraintsTo:_topNav visualFormat:@"V:[_subNavRed]-0-[_subNavYellow]"];
    [self addContraintsTo:_topNav visualFormat:@"H:|-0-[_subNavYellow]-0-|"];
}
@end

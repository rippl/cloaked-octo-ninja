//
//  ViewController.m
//  e rcv
//
//  Created by Charles Yang on 31/10/13.
//  Copyright (c) 2013 Charles Yang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Maj1Min1ViewController.h"
#import "Maj1Min2ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)addMotionEffectToView:(UIView*)view                       magnitude:(float)magnitude {
    
    UIInterpolatingMotionEffect* xMotion =               [[UIInterpolatingMotionEffect alloc]                         initWithKeyPath:@"center.x"
                                                          
                                                                                                                                 type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];     xMotion.minimumRelativeValue = @(-magnitude);     xMotion.maximumRelativeValue = @(magnitude);
    
    UIInterpolatingMotionEffect* yMotion =              [[UIInterpolatingMotionEffect alloc]                        initWithKeyPath:@"center.y"
                                                         
                                                                                                                               type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];     yMotion.minimumRelativeValue = @(-magnitude);     yMotion.maximumRelativeValue = @(magnitude);
    
    UIMotionEffectGroup* group = [[UIMotionEffectGroup alloc]                                                         init];     group.motionEffects = @[xMotion, yMotion];
    
    [view addMotionEffect:group];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    minorVal = 0;
    
    [self addMotionEffectToView:_titleImageView magnitude:10.0f];
    [self addMotionEffectToView:_visualImageView magnitude:-10.0f];
    [self addMotionEffectToView:_textBodyView magnitude:10.0f];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidRangeNearBeaconNotification:) name:DidRangeNearBeaconNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidPopViewCNotification:) name:@"DidPopViewCNotification" object:nil];
    
    //UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
    //UIImage *image = [UIImage imageNamed:@"ikea-logo.png"];
    //[navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ikea-logo-bar.png"]];

    /*
    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    Maj1Min1ViewController *controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
    [navigationController pushViewController:controller animated:YES];
    */
}

- (void)handleDidPopViewCNotification:(NSNotification *)note {
    //minorVal = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Maj1Min3ViewController.m
//  
//
//  Created by Charles Yang on 7/11/13.
//
//

#import "Maj1Min3ViewController.h"
#import "BeaconMonitoringService.h"

@interface Maj1Min3ViewController ()

@end

@implementation Maj1Min3ViewController

- (void)addMotionEffectToView:(UIView*)view                       magnitude:(float)magnitude {
    
    UIInterpolatingMotionEffect* xMotion =               [[UIInterpolatingMotionEffect alloc]                         initWithKeyPath:@"center.x"
                                                          
                                                                                                                                 type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];     xMotion.minimumRelativeValue = @(-magnitude);     xMotion.maximumRelativeValue = @(magnitude);
    
    UIInterpolatingMotionEffect* yMotion =              [[UIInterpolatingMotionEffect alloc]                        initWithKeyPath:@"center.y"
                                                         
                                                                                                                               type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];     yMotion.minimumRelativeValue = @(-magnitude);     yMotion.maximumRelativeValue = @(magnitude);
    
    UIMotionEffectGroup* group = [[UIMotionEffectGroup alloc]                                                         init];     group.motionEffects = @[xMotion, yMotion];
    
    [view addMotionEffect:group];
}


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
    
    [self addMotionEffectToView:_visualImageView magnitude:-15.0f];
    [self addMotionEffectToView:_contentBodyView magnitude:15.0f];
    
    CALayer *btnLayer = [_addButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    btnLayer = [_moreButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    //self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ikea-logo-bar.png"]];
    //self.navigationController.delegate = self;
}


-(void) viewDidDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        NSLog(@"Popppped!!!");
        [BeaconMonitoringService sharedInstance].vcPushed = NO;
    }
    [super viewDidDisappear:animated];
}


/*
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"DidPopViewCNotification" object:self userInfo:nil];
}
*/

- (IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidDismissView" object:self userInfo:nil];;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

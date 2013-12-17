//
//  PromoViewController.m
//  e rcv
//
//  Created by Charles Yang on 13/11/13.
//  Copyright (c) 2013 Charles Yang. All rights reserved.
//

#import "PromoViewController.h"
#import "AppDelegate.h"
#import "Maj1Min1ViewController.h"
#import "Maj1Min2ViewController.h"
#import "Maj1Min3ViewController.h"
#import "BeaconMonitoringService.h"
#import "CTCardCell.h"
#import "FlipAnimationController.h"
#import "SwipeInteractionController.h"
#import <QuartzCore/QuartzCore.h>

@interface PromoViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray *members;
@property (assign, nonatomic) CATransform3D initialTransformation;

@end

@implementation PromoViewController
{
    FlipAnimationController *_flipAnimationController;
    //SwipeInteractionController *_interactionController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _flipAnimationController = [FlipAnimationController new];
        //_interactionController = [SwipeInteractionController new];
        self.modViewDisplayed = NO;
    }
    return self;
}

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"viewDidLoad");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidRangeNearBeaconNotification:) name:DidRangeNearBeaconNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidDismissViewNotification:) name:@"DidDismissView" object:nil];
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TeamMembers" ofType:@"json"]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    self.members = json[@"team"];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab2bg.png"]];
    
    CGFloat rotationAngleDegrees = -15;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(-50, 0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 0.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 1.0);
    _initialTransformation = transform;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ikea-logo-bar.png"]];
    self.navigationController.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)beaconRanged
{
    NSLog(@"beaconRanged");
    
    // if vc pushed, pop it
    // push appropriate vc based on minor
    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
    //if ([BeaconMonitoringService sharedInstance].vcPushed == YES)
    //{
        [navigationController popToRootViewControllerAnimated:NO];
        //[BeaconMonitoringService sharedInstance].vcPushed = NO;
    //}
    
    //[BeaconMonitoringService sharedInstance].vcPushed = YES;
    
    //[navigationController popToRootViewControllerAnimated:NO];
    //[navigationController popToViewController:[navigationController topViewController] animated:NO];
    
    int minorVal = [[BeaconMonitoringService sharedInstance] bMinorVal];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    //Maj1Min1ViewController *controller;
    
    if (minorVal == 2)
    {
        Maj1Min1ViewController *controller;
        controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
        //[UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //    [navigationController pushViewController:controller animated:NO];
        //}
        //                completion:NULL];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (minorVal == 1)
    {
        Maj1Min2ViewController *controller;
        controller = (Maj1Min2ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min2ViewController"];
        //[UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //    [navigationController pushViewController:controller animated:NO];
        //}
        //                completion:NULL];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (minorVal == 3)
    {
        Maj1Min3ViewController *controller;
        controller = (Maj1Min3ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min3ViewController"];
        //[UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //    [navigationController pushViewController:controller animated:NO];
        //}
        //                completion:NULL];
        [navigationController pushViewController:controller animated:YES];
    }
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Maj1Min1"])
	{
		;//Maj1Min1ViewController *nwvc = segue.destinationViewController;
	}
    else if ([segue.identifier isEqualToString:@"Maj1Min1"])
	{
		;//Maj1Min1ViewController *nwvc = segue.destinationViewController;
	}
    else if ([segue.identifier isEqualToString:@"Maj1Min1"])
	{
		;//Maj1Min1ViewController *nwvc = segue.destinationViewController;
	}
}



- (void)beaconRanged
{
    //NSLog(@"beaconRanged");
    
    // if vc pushed, pop it
    // push appropriate vc based on minor
    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
    [navigationController popToRootViewControllerAnimated:NO];
    
    int minorVal = [[BeaconMonitoringService sharedInstance] bMinorVal];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    
    if (minorVal == 29846)
    {
        //[self dismissViewControllerAnimated:YES completion:nil];
        
        if (self.modViewDisplayed == YES)
            [self dismissViewControllerAnimated:YES completion:^{
                [self performSegueWithIdentifier:@"Maj1Min1" sender:self];
            }];
        else
        {
            [self performSegueWithIdentifier:@"Maj1Min1" sender:self];
            self.modViewDisplayed = YES;
        }
        
        //[self performSegueWithIdentifier:@"Maj1Min1" sender:self];
        /*
        Maj1Min1ViewController *controller;
        controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
        [navigationController pushViewController:controller animated:YES];
        */
    }
    else if (minorVal == 29542)
    {
        if (self.modViewDisplayed == YES)
            [self dismissViewControllerAnimated:YES completion:^{
                [self performSegueWithIdentifier:@"Maj1Min2" sender:self];
            }];
        else
        {
            [self performSegueWithIdentifier:@"Maj1Min2" sender:self];
            self.modViewDisplayed = YES;
        }
        
        //[self performSegueWithIdentifier:@"Maj1Min2" sender:self];
        /*
        Maj1Min2ViewController *controller;
        controller = (Maj1Min2ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min2ViewController"];
        [navigationController pushViewController:controller animated:YES];
        */
    }
    else if (minorVal == 46948)
    {
        //[self dismissViewControllerAnimated:YES completion:nil];
        
        if (self.modViewDisplayed == YES)
            [self dismissViewControllerAnimated:YES completion:^{
                [self performSegueWithIdentifier:@"Maj1Min3" sender:self];
            }];
        else
        {
            [self performSegueWithIdentifier:@"Maj1Min3" sender:self];
            self.modViewDisplayed = YES;
        }
        //[self performSegueWithIdentifier:@"Maj1Min3" sender:self];
        /*
        Maj1Min3ViewController *controller;
        controller = (Maj1Min3ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min3ViewController"];
        [navigationController pushViewController:controller animated:YES];
        */
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //NSLog(@"viewWillAppear");
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //NSLog(@"viewDidAppear");
    
    if ([BeaconMonitoringService sharedInstance].notifSent == YES)
    {
        [BeaconMonitoringService sharedInstance].notifSent = NO;
        
        [self beaconRanged];
        /*
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
        Maj1Min1ViewController *controller;
        controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
        [UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [navigationController pushViewController:controller animated:NO];
        }
                        completion:NULL];
        [BeaconMonitoringService sharedInstance].vcPushed = NO;
        */
    }
}


- (void)handleDidRangeNearBeaconNotification:(NSNotification *)note {
    
    NSString *notifType = note.userInfo[@"NotifType"];
    NSString *major = note.userInfo[@"Major"];
    NSString *minor = note.userInfo[@"Minor"];
    //NSLog(@"handleDidRangeNearBeaconNotification: Major %@, Minor %@\n\n\n\n\n\n", major, minor);
    NSLog(@"handleDidRangeNearBeaconNotification");
    
    [self beaconRanged];
    /*
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
    Maj1Min1ViewController *controller;
    controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
    [UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [navigationController pushViewController:controller animated:NO];
    }
                    completion:NULL];
    [BeaconMonitoringService sharedInstance].vcPushed = NO;
    */
}



- (void)handleDidDismissViewNotification:(NSNotification *)note {
    NSLog(@"handleDidDismissViewNotification");
    self.modViewDisplayed = NO;
}

//- (void)handleDidRangeNearBeaconNotification:(NSNotification *)note {
    
    
//    NSLog(@"handleDidRangeNearBeaconNotification");
    /*
    ESTBeacon *b = note.userInfo[@"beacon"];
    
    NSLog(@"proximity - %i", b.ibeacon.proximity);
    NSLog(@"major     - %@", b.ibeacon.major);
    NSLog(@"minor     - %@", b.ibeacon.minor);
    NSLog(@"accuracy  - %f", b.ibeacon.accuracy);
    NSLog(@"rssi      - %i", b.ibeacon.rssi);
    */
    //if (minorVal != [b.ibeacon.minor integerValue])
    //{
    //    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
    /*
        //if (minorVal != 0)
        if ([BeaconMonitoringService sharedInstance].vcPushed == YES)
        {
            [navigationController popViewControllerAnimated:NO];
            [BeaconMonitoringService sharedInstance].vcPushed = NO;
        }
    */
    
    
    /*
        //minorVal = [b.ibeacon.minor integerValue];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    
        //if (minorVal == 2)
        //if ([b.ibeacon.minor integerValue] == 2)
        //{
            Maj1Min1ViewController *controller;
            controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
            [UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                [navigationController pushViewController:controller animated:NO];
            }
                            completion:NULL];
    */
        /*}
        else if ([b.ibeacon.minor integerValue] == 1)
        {
            Maj1Min2ViewController *controller;
            controller = (Maj1Min2ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min2ViewController"];
            [UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                [navigationController pushViewController:controller animated:NO];
            }
                            completion:NULL];
        }*/
    //}
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.members count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    NSString *aboutText = _members[indexPath.row][@"about"];
    NSString *newlineString = @"\n";
    NSString *newAboutText = [aboutText stringByReplacingOccurrencesOfString:@"\\n" withString:newlineString];
    
    
    //CGSize aboutSize = [newAboutText sizeWithFont:font constrainedToSize:CGSizeMake(268, 4000)];
    
    // if deployment target is iOS7 and you want to get rid of the warning above
    // comment the line above and uncomment the following section
    
    // ios 7 only
    /*
    CGRect boundingRect = [newAboutText boundingRectWithSize:CGSizeMake(268, 4000)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    CGSize boundingSize = boundingRect.size;
    */ 
    // end ios7 only
    
    return (280-15);
    //return (280-15+boundingSize.height);
    //return (280-15+aboutSize.height);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *card = [(CTCardCell* )cell mainView];
    
    card.layer.transform = self.initialTransformation;
    card.layer.opacity = 0.8;
    
    [UIView animateWithDuration:0.4 animations:^{
        card.layer.transform = CATransform3DIdentity;
        card.layer.opacity = 1;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PromoCell";
    CTCardCell *cell = (CTCardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell setupWithDictionary:[self.members objectAtIndex:indexPath.row]];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    //if ([BeaconMonitoringService sharedInstance].vcPushed == NO)
    //{
    //    [BeaconMonitoringService sharedInstance].vcPushed = YES;
    
    
    
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    
    
    if ([indexPath row] == 1 || [indexPath row] == 4 || [indexPath row] == 7) {
        //[BeaconMonitoringService sharedInstance].bMinorVal = 2;
        Maj1Min1ViewController *controller;
        controller = (Maj1Min1ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min1ViewController"];
        
        //[UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //    [navigationController pushViewController:controller animated:NO];
        //}
        //                completion:NULL];
        [navigationController pushViewController:controller animated:YES];
    }
    else if ([indexPath row] == 0 || [indexPath row] == 3) {
        //[BeaconMonitoringService sharedInstance].bMinorVal = 1;
        Maj1Min2ViewController *controller;
        controller = (Maj1Min2ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min2ViewController"];
        
        //[UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //    [navigationController pushViewController:controller animated:NO];
        //}
        //                completion:NULL];
        [navigationController pushViewController:controller animated:YES];
    }
    else if ([indexPath row] == 2 || [indexPath row] == 5) {
        //[BeaconMonitoringService sharedInstance].bMinorVal = 3;
        Maj1Min3ViewController *controller;
        controller = (Maj1Min3ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"Maj1Min3ViewController"];
        
        //[UIView transitionWithView:navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        //[navigationController pushViewController:controller animated:NO];
        //}
        //completion:NULL];
        [navigationController pushViewController:controller animated:YES];
    }
     
        
        
    //}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - UINavigationControllerDelegate
/*
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    //if (operation == UINavigationControllerOperationPush) {
    //    [_interactionController wireToViewController:toVC];
    //}
    
    _flipAnimationController.reverse = operation == UINavigationControllerOperationPop;
    return _flipAnimationController;
}
*/

/*
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    
    return _interactionController.interactionInProgress ? _interactionController : nil;
}
*/

@end

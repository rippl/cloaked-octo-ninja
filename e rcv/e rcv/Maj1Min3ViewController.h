//
//  Maj1Min3ViewController.h
//  
//
//  Created by Charles Yang on 7/11/13.
//
//

#import <UIKit/UIKit.h>

@interface Maj1Min3ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *visualImageView;
@property (weak, nonatomic) IBOutlet UIView *contentBodyView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

//- (IBAction)back:(id)sender;
- (IBAction)cancel:(id)sender;

@end

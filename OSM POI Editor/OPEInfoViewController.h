//
//  OPEInfoViewController.h
//  OSM POI Editor
//
//  Created by David Chiles on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuthViewControllerTouch.h"

@interface OPEInfoViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton * loginButton;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)logoutButtonPressed:(id)sender;

- (void) signInToOSM;
- (GTMOAuthAuthentication *)osmAuth;
- (void) signOutOfOSM;

@end

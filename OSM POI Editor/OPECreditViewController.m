//
//  OPECreditViewController.m
//  OSM POI Editor
//
//  Created by David Chiles on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPECreditViewController.h"


@interface OPECreditViewController ()

@end


@implementation OPECreditViewController

@synthesize webView;
@synthesize lastURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    [self loadWebView];
    [webView setDelegate:self];
}

-(IBAction)doneButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) loadWebView
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"]isDirectory:NO]]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma - WebView
-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString rangeOfString:@"file:///"].location !=NSNotFound) {
        return YES;
    }
    if ([[[request URL] scheme] isEqual:@"mailto"]) {
        NSLog(@"mailto tapped");
        [[UIApplication sharedApplication] openURL:[request URL]];
        
        return NO;
    }
    else if ([[UIApplication sharedApplication] canOpenURL:request.URL])
    {
        self.lastURL = request.URL;
        UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:[[request.URL absoluteURL] description] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
        [action showInView:self.view];
        return NO;
    }
    return NO;
    
}

#pragma ActionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        [[UIApplication sharedApplication] openURL:[lastURL absoluteURL]];
    }
}   
@end

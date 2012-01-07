//
//  FirstViewController.m
//  Conclusively_iOS
//
//  Created by Maverick Lee on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
NSMutableData *webData = NULL;
NSString *returnStr = NULL;
UIButton *button;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView {
    
    //allocate the view
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    // set the view's background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    // create the button
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(119, 188, 72, 37);
    [button setTitle:@"Go!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) 
     forControlEvents:UIControlEventTouchUpInside];
    
    // create label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(54, 98, 212, 43)];
    label.text = @"Search";
    label.font = [UIFont systemFontOfSize:36];
    label.textAlignment = UITextAlignmentCenter;

    // create text field
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(54, 149, 212, 31)];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    
    // add items to view
    [self.view addSubview:button];
    [self.view addSubview:label];
    [self.view addSubview:textfield];
}

- (void)buttonPressed
// Starts a connection to download the current URL.
{
    NSString *str = @"http://kanaflash.com/c/search";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    webData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    returnStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:returnStr delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alert show];
    self.parentViewController.tabBarController.selectedViewController = [self.parentViewController.tabBarController.viewControllers objectAtIndex:1];
}

- (IBAction)sendData:(id)sender {
    [self buttonPressed];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end

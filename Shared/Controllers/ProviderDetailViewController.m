//
//  ProviderDetailViewController.m
//  BioMonitor
//
//  Created by Mannie Tagarira on 17/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProviderDetailViewController.h"


@implementation ProviderDetailViewController

@synthesize providerServicesViewController;


#pragma mark -
#pragma mark Helpers

-(void) updateWithProperties:(NSDictionary *)properties {    
  [providerProperties release];
  providerProperties = [properties retain];
  
  [uiContentController updateProviderUIElementsWithProperties:properties];
  
  [self.view setNeedsDisplay];  
  
} // updateWithProperties


#pragma mark -
#pragma mark  IBActions

-(void) showServices:(id)sender {
  [providerServicesViewController loadView];

  NSString *providerID = [[providerProperties objectForKey:JSONResourceElement] lastPathComponent];
  [providerServicesViewController updateWithServicesFromProviderWithID:[providerID intValue]];

  [self.navigationController pushViewController:providerServicesViewController animated:YES];  
} // showServices


#pragma mark -
#pragma mark View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
} // shouldAutorotateToInterfaceOrientation

-(void) makeShowServicesButtonVisible:(BOOL)visible {
  if (visible) {
    self.navigationItem.rightBarButtonItem = servicesButton;
  } else {
    self.navigationItem.rightBarButtonItem = nil;
  }
} // makeShowServicesButtonVisible


#pragma mark -
#pragma mark Memory management

-(void) releaseIBOutlets {
  [servicesButton release];
  [uiContentController release];
  
  [providerServicesViewController release];
} // releaseIBOutlets

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
} // didReceiveMemoryWarning

- (void)viewDidUnload {
  [super viewDidUnload];

  [self releaseIBOutlets];
} // viewDidUnload

- (void)dealloc {
  [self releaseIBOutlets];
  [providerProperties release];
  
  [super dealloc];
} // dealloc


@end

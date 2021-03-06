//
//  PullToRefreshViewController.m
//  TableViewPull
//
//  Created by Devin Doty on 10/16/09October16.
//  Modified by Mannie Tagarira on February 1, 2011
//  Copyright enormego 2009. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "AppImports.h"

#import "PullToRefreshViewController.h"
#import "EGORefreshTableHeaderView.h"


@interface PullToRefreshViewController (Private)

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

- (void)dataSourceDidFinishLoadingNewData;

@end


@implementation PullToRefreshViewController

@synthesize reloading=_reloading;


- (void)viewDidLoad {
  [super viewDidLoad];
  
	if (refreshHeaderView == nil) {
    contentOffset = ([[UIDevice currentDevice] isIPadDevice] ? -100.0f : -65.0f);
    float height = ([[UIDevice currentDevice] isIPadDevice] ? 0.0f : [[self tableView] bounds].size.height);
    
    refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - height, 320.0f, height)];
    if ([[UIDevice currentDevice] isIPadDevice]) {  
      [[self tableView] setTableHeaderView:refreshHeaderView];
    } else {
      [[self tableView] addSubview:refreshHeaderView];
    }
    [refreshHeaderView setBackgroundColor:[UIColor whiteColor]];
    [refreshHeaderView release];
    
		[[self tableView] setShowsVerticalScrollIndicator:YES];
	}
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}

- (void)viewDidUnload {
	refreshHeaderView=nil;
	[super viewDidUnload];
}


#pragma mark Table view methods

- (void)reloadTableViewDataSource{
  dispatch_async(dispatch_queue_create("Refresh TableView Data Source", NULL), ^{      
    if ([self respondsToSelector:@selector(refreshTableViewDataSource)]) {
      [self performSelector:@selector(refreshTableViewDataSource)];
    }
  });
  
  [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.5];
}


- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	[self dataSourceDidFinishLoadingNewData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if ([scrollView isDragging]) {
		if ([refreshHeaderView state] == EGOOPullRefreshPulling && [scrollView contentOffset].y > contentOffset && [scrollView contentOffset].y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
    } else if ([refreshHeaderView state] == EGOOPullRefreshNormal && [scrollView contentOffset].y < contentOffset && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{  
	if ([scrollView contentOffset].y <= contentOffset && !_reloading && [[UIDevice currentDevice] hasInternetConnection]) {
    _reloading = YES;
    [self reloadTableViewDataSource];
    [refreshHeaderView setState:EGOOPullRefreshLoading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [[self tableView] setContentInset:UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
	}
}

- (void)dataSourceDidFinishLoadingNewData{
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[[self tableView] setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
  
  [[self tableView] reloadData];
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	refreshHeaderView = nil;
  
  [super dealloc];
}


@end


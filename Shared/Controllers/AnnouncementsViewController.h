//
//  AnnouncementsViewController.h
//  BioMonitor
//
//  Created by Mannie Tagarira on 07/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshViewController.h"

#import "MWFeedParser.h"
#import "NSString+HTML.h"

#import "BioCatalogueResourceManager.h"
#import "AppDelegate_Shared.h"

#import "DetailViewController_iPad.h"
#import "AnnouncementDetailViewController_iPhone.h"

@interface AnnouncementsViewController : PullToRefreshViewController <PullToRefreshDataSource, MWFeedParserDelegate> {
	MWFeedParser *feedParser;
	NSMutableArray *announcements;
}

@property (nonatomic, retain) IBOutlet DetailViewController_iPad *iPadDetailViewController;
@property (nonatomic, retain) IBOutlet AnnouncementDetailViewController_iPhone *iPhoneDetailViewController;

@end

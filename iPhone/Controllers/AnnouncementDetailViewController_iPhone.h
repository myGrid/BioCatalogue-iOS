//
//  AnnouncementDetailViewController_iPhone.h
//  BioMonitor
//
//  Created by Mannie Tagarira on 07/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface AnnouncementDetailViewController_iPhone : UIViewController {
  IBOutlet UIContentController *uiContentController;

  BOOL viewHasBeenUpdated;
  NSUInteger currentAnnouncementID;
}

-(void) updateWithPropertiesForAnnouncementWithID:(NSUInteger)announcementID;

@end

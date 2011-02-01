//
//  UIContentController.h
//  BioMonitor
//
//  Created by Mannie Tagarira on 08/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppConstants.h"

#import "NSString+Helper.h"
#import "NSDictionary+Helper.h"

#import "BioCatalogueClient.h"

#import "Service.h"


@interface UIContentController : NSObject {
  // the service view
  IBOutlet UILabel *serviceName;
  IBOutlet UITextView *serviceDescription;
  IBOutlet UILabel *serviceProviderName;
  IBOutlet UILabel *serviceSubmitterName;
  
  IBOutlet UILabel *serviceComponents;
  IBOutlet UIButton *showComponentsButton;

  IBOutlet UIImageView *monitoringStatusIcon;
  
  // user details
  IBOutlet UILabel *userName;
  IBOutlet UILabel *userAffiliation;
  IBOutlet UILabel *userCountry;
  IBOutlet UILabel *userCity;
  IBOutlet UILabel *userEmail;
  IBOutlet UILabel *userJoinedDate;
  
  // provider details
  IBOutlet UILabel *providerName;
  IBOutlet UITextView *providerDescription;  
}

+(void) setTableViewBackground:(UITableView *)tableView;

+(void) customiseTableViewCell:(UITableViewCell *)cell withService:(Service *)service;
+(void) customiseTableViewCell:(UITableViewCell *)cell 
                withProperties:(NSDictionary *)properties
                    givenScope:(NSString *)scope;

-(void) updateServiceUIElementsWithService:(Service *)service;
-(void) updateServiceUIElementsWithProperties:(NSDictionary *)listingProperties 
                                 providerName:(NSString *)providerName 
                                submitterName:(NSString *)submitterName 
                              showLoadingText:(BOOL)isBusy;
-(void) updateUserProviderUIElementsWithProperties:(NSDictionary *)properties;
-(void) updateProviderUIElementsWithProperties:(NSDictionary *)properties;

@end

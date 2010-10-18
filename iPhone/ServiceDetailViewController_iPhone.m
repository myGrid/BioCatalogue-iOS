//
//  ServiceDetailViewController_iPhone.m
//  BioMonitor
//
//  Created by Mannie Tagarira on 08/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ServiceDetailViewController_iPhone.h"


@implementation ServiceDetailViewController_iPhone

@synthesize userDetailViewController, providerDetailViewController;
@synthesize monitoringStatusViewController, descriptionViewController;


#pragma mark -
#pragma mark Helpers

-(void) updateWithProperties:(NSDictionary *)properties {
  NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
  
  // capture all the instances that need to be released
  // tableView:cellForRowAtIndexPath: needs the ...Properties dictionaries
  // this section is made to avoid the callback making calls to a released var
  NSDictionary *serviceListingPropertiesToRelease = serviceListingProperties;
  NSDictionary *servicePropertiesToRelease = serviceProperties;
  NSDictionary *submitterPropertiesToRelease = submitterProperties;
  
  // fetch the latest properties
  self.view.userInteractionEnabled = NO;
  
  serviceListingProperties = [properties copy];

  NSURL *resourceURL = [NSURL URLWithString:[properties objectForKey:JSONResourceElement]];  
  serviceProperties = [[[JSON_Helper helper] documentAtPath:[resourceURL path]] copy];

  NSString *lastChecked = [NSString stringWithFormat:@"%@", 
                           [[properties objectForKey:JSONLatestMonitoringStatusElement] objectForKey:JSONLastCheckedElement]];
  monitoringStatusInformationAvailable = ![lastChecked isEqualToString:JSONNull];

  NSURL *submitterURL = [NSURL URLWithString:[properties objectForKey:JSONSubmitterElement]];
  submitterProperties = [[[JSON_Helper helper] documentAtPath:[submitterURL path]] copy];
  
  name.text = [serviceListingProperties objectForKey:JSONNameElement];
  
  [[self tableView] reloadData];
  self.view.userInteractionEnabled = YES;
  
  // now release the var
  [serviceListingPropertiesToRelease release];
  [servicePropertiesToRelease release];
  [submitterPropertiesToRelease release];
  
  [autoreleasePool drain];
} // updateWithProperties


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  monitoringStatusInformationAvailable = NO;
  descriptionAvailable = NO;
  
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  if (section == 2) {
    return 2;
  } else {
    return 1;
  }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Configure the cell...
  NSString *value;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  if (indexPath.section == 0) {
    cell.imageView.image = [UIImage imageNamed:@"info"];
    cell.detailTextLabel.text = @"Description";

    value = [NSString stringWithFormat:@"%@", [serviceListingProperties objectForKey:JSONDescriptionElement]];
    descriptionAvailable = ![value isEqualToString:JSONNull];
    
    if (descriptionAvailable) {
      cell.textLabel.text = value;
    } else {
      cell.textLabel.text = @"No description";
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  } else if (indexPath.section == 1) {
    id monitoringElement = [serviceListingProperties objectForKey:JSONLatestMonitoringStatusElement];
    id image = [NSURL URLWithString:[monitoringElement objectForKey:JSONSmallSymbolElement]];
    cell.imageView.image = [UIImage imageNamed:[[image lastPathComponent] stringByDeletingPathExtension]];
    
    cell.detailTextLabel.text = @"Monitoring";
    cell.textLabel.text = [monitoringElement objectForKey:JSONLabelElement];

    if (!monitoringStatusInformationAvailable) {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  } else if (indexPath.section == 2) {
    if (indexPath.row == 0) {
      cell.imageView.image = [UIImage imageNamed:@"112-group"];
      cell.detailTextLabel.text = @"Service Provider";
      
      id provider = [[[[serviceProperties objectForKey:JSONDeploymentsElement] lastObject]
                      objectForKey:JSONProviderElement] objectForKey:JSONNameElement];
      cell.textLabel.text = provider;
    } else {
      cell.imageView.image = [UIImage imageNamed:@"59-flag"];
      cell.detailTextLabel.text = @"Location";
      id country = [[[[serviceProperties objectForKey:JSONDeploymentsElement] lastObject] 
                     objectForKey:JSONLocationElement] objectForKey:JSONCountryElement];
      
      if ([[NSString stringWithFormat:@"%@", country] isEqualToString:JSONNull]) {
        cell.textLabel.text = @"Unknown";
      } else {
        cell.textLabel.text = country;
      }
      
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  } else {
    cell.imageView.image = [UIImage imageNamed:@"111-user"];
    cell.detailTextLabel.text = @"Submitter";
    cell.textLabel.text = [submitterProperties objectForKey:JSONNameElement];
  }
    
  return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    // descriptions
    if (descriptionAvailable) {
      [descriptionViewController loadView];
      id description = [NSString stringWithFormat:@"%@", [serviceListingProperties objectForKey:JSONDescriptionElement]];
      descriptionViewController.descriptionTextView.text = description;
      [self.navigationController pushViewController:descriptionViewController animated:YES];
    } else {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
      descriptionViewController.descriptionTextView.text = @"";
    }
  } else if (indexPath.section == 1) {
    // monitoring statuses
    if (monitoringStatusInformationAvailable) {
      NSURL *serviceURL = [NSURL URLWithString:[serviceListingProperties objectForKey:JSONResourceElement]];
      NSString *path = [[serviceURL path] stringByAppendingPathComponent:@"monitoring"];
      
      NSThread *downloadThread = [[NSThread alloc] initWithTarget:monitoringStatusViewController 
                                                         selector:@selector(fetchMonitoringStatusInfo:) 
                                                           object:path];
      [downloadThread start];
      [downloadThread release];

      [self.navigationController pushViewController:monitoringStatusViewController animated:YES];
    } else {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
  } else if (indexPath.section == 2) {
    if (indexPath.row == 0) {
      // service provider
      id properties = [[[serviceProperties objectForKey:JSONDeploymentsElement] lastObject] objectForKey:JSONProviderElement];
      
      [providerDetailViewController loadView];
      [providerDetailViewController updateWithProperties:properties];
      [self.navigationController pushViewController:providerDetailViewController animated:YES];
    } else {
      // location
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
  } else {
    // submitting user
    [userDetailViewController loadView];
    [userDetailViewController updateWithProperties:submitterProperties];
    [self.navigationController pushViewController:userDetailViewController animated:YES];    
  }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
  // For example: self.myOutlet = nil;
}

- (void)dealloc {  
  [userDetailViewController release];
  [providerDetailViewController release];
  
  [monitoringStatusViewController release];
  [descriptionViewController release];
  
  [serviceListingProperties release];
  [serviceProperties release];
  [submitterProperties release];
  
  [super dealloc];
}


@end

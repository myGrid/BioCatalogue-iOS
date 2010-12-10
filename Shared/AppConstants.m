//
//  AppConstants.m
//  BioMonitor
//
//  Created by Mannie Tagarira on 05/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppConstants.h"


#pragma mark -
#pragma mark BioCatalogueClient

NSUInteger const iPadItemsPerPage = 15;
NSUInteger const iPhoneItemsPerPage = 10;
NSUInteger ItemsPerPage = 10;

NSString *const UserResourceScope = @"users";
NSString *const ServiceResourceScope = @"services";
NSString *const ProviderResourceScope = @"providers";

NSString *const RESTService = @"REST";
NSString *const SOAPService = @"SOAP";

NSString *const BioCatalogueHostname = @"sandbox.biocatalogue.org";
//NSString *const BioCatalogueHostname = @"test.biocatalogue.org";
//NSString *const BioCatalogueHostname = @"www.biocatalogue.org";
//NSString *const BioCatalogueHostname = @"demo.edunify.pesc.org";


#pragma mark -
#pragma mark BioCatalogue Search Indexes

NSUInteger const ServiceResourceScopeIndex = 0;
NSUInteger const UserResourceScopeIndex = 1;
NSUInteger const ProviderResourceScopeIndex = 2;


#pragma mark -
#pragma mark JSON Elements

NSString *const JSONFormat = @"json";
NSString *const XMLFormat = @"xml";

NSString *const JSONNull = @"<null>";

NSString *const JSONAffiliationElement = @"affiliation";
NSString *const JSONCityElement = @"city";
NSString *const JSONCountryCodeElement = @"country_code";
NSString *const JSONCountryElement = @"country";
NSString *const JSONDeploymentsElement = @"deployments";
NSString *const JSONDescriptionElement = @"description";
NSString *const JSONEndpointLabelElement = @"endpoint_label";
NSString *const JSONErrorsElement = @"errors";
NSString *const JSONFlagElement = @"flag";
NSString *const JSONJoinedElement = @"joined";
NSString *const JSONLabelElement = @"label";
NSString *const JSONLastCheckedElement = @"last_checked";
NSString *const JSONLatestMonitoringStatusElement = @"latest_monitoring_status";
NSString *const JSONLocationElement = @"location";
NSString *const JSONMethodsElement = @"methods";
NSString *const JSONNameElement = @"name";
NSString *const JSONOperationsElement = @"operations";
NSString *const JSONPagesElement = @"pages";
NSString *const JSONProviderElement = @"provider";
NSString *const JSONPublicEmailElement = @"public_email";
NSString *const JSONResourceElement = @"resource";
NSString *const JSONResultsElement = @"results";
NSString *const JSONSearchQueryElement = @"search_query";
NSString *const JSONSelfElement = @"self";
NSString *const JSONServiceTestsElement = @"service_tests";
NSString *const JSONSmallSymbolElement = @"small_symbol";
NSString *const JSONStatusElement = @"status";
NSString *const JSONSubmitterElement = @"submitter";
NSString *const JSONSymbolElement = @"symbol";
NSString *const JSONTechnologyTypesElement = @"service_technology_types";
NSString *const JSONTestTypeElement = @"test_type";
NSString *const JSONTotalElement = @"total";
NSString *const JSONURLElement = @"url";
NSString *const JSONURLMonitorElement = @"url_monitor";
NSString *const JSONVariantsElement = @"variants";


#pragma mark -
#pragma mark Image Names

NSString *const DescriptionIcon = @"info";
NSString *const ProviderIcon = @"112-group.png";
NSString *const UserIcon = @"111-user.png";
NSString *const BrushedMetalBackground = @"BrushedMetalBack.jpg";


#pragma mark -
#pragma mark NSUserDefaults

NSString *const LastViewedResourceKey = @"LastViewedResource";
NSString *const LastViewedResourceScopeKey = @"LastViewedResourceScope";


#pragma mark -
#pragma mark Text Placeholders

NSString *UnknownText = @"Unknown";
NSString *DefaultLoadingText = @"Loading, Please Wait...";

NSString *NoDescriptionText = @"(no description available)";
NSString *NoInformationText = @"(no information available)";

NSString *RESTComponentsText = @"REST Endpoints";
NSString *SOAPComponentsText = @"SOAP Operations";



/* * *** *** *** ** *** *** *** ** *** *** *** ** *** *** *** ** *** *** *** * */


@implementation AppConstants

@end

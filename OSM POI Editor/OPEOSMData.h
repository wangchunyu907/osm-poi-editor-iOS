//
//  OSMData.h
//  OSM POI Editor
//
//  Created by David Chiles on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OPETagInterpreter.h"
#import "GTMOAuthViewControllerTouch.h"

@interface OPEOSMData : NSObject 
{
    GTMOAuthAuthentication *auth;
    OPETagInterpreter * tagInterpreter;
    
}

@property (nonatomic, strong) NSMutableDictionary * allNodes;
@property (nonatomic, strong) NSMutableDictionary * ignoreNodes;
@property (nonatomic, strong) GTMOAuthAuthentication * auth;

- (void) getDataWithSW:(CLLocationCoordinate2D)southWest NE: (CLLocationCoordinate2D) northEast;
- (NSInteger) openChangesetWithMessage: (NSString *) message;
- (int) createXmlNode: (OPENode *) node withChangeset: (NSInteger) changesetNumber;
- (int) updateXmlNode: (OPENode *) node withChangeset: (NSInteger) changesetNumber;
- (int) deleteXmlNode: (OPENode *) node withChangeset: (NSInteger) changesetNumber;
- (void) closeChangeset: (NSInteger) changesetNumber;
- (BOOL) canAuth;

- (int) createNode: (OPENode *) node;
- (int) updateNode: (OPENode *) node;
- (int) deleteNode: (OPENode *) node;
- (void) uploadComplete;
+ (void) HTMLFix:(OPENode *)node;
+(void) backToHTML:(OPENode *)node;



@end

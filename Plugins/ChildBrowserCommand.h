//
//  PhoneGap ! ChildBrowserCommand
// 
//
//  Created by Jesse MacFadyen on 10-05-29.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneGapCommand.h"
#import "MapViewController.h"


//BMCA Add the delegate to the interface
 
@interface ChildBrowserCommand : PhoneGapCommand<MapViewControllerDelegate>  {
	int IDselected;

}

- (void) showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) showMap:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;


@end

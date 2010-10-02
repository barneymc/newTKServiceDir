//

// 
//
//  Created by Jesse MacFadyen on 10-05-29.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import "ChildBrowserCommand.h"
#import "ChildBrowserViewController.h"
#import "PhoneGapViewController.h"
#import "MapViewController.h"


@implementation ChildBrowserCommand

- (void) showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{	
	ChildBrowserViewController* childBrowser = [ [ ChildBrowserViewController alloc ] initWithScale:FALSE ];
	
/* // TODO: Work in progress
	NSString* strOrientations = [ options objectForKey:@"supportedOrientations"];
	NSArray* supportedOrientations = [strOrientations componentsSeparatedByString:@","];
*/
	PhoneGapViewController* cont = (PhoneGapViewController*)[ super appViewController ];
	//childBrowser.supportedOrientations = cont.supportedOrientations;
	[ cont presentModalViewController:childBrowser animated:YES ];
	
	NSString *url = (NSString*) [arguments objectAtIndex:0];

	[childBrowser loadURL:url  ];
	[childBrowser release];
}


//Implement the delegate method - this receives the call 
//from the MapViewController
//
- (void) pinSelected:(int)pinIDSelected
{
	NSString *testy;
	IDselected=pinIDSelected;
	//testy=[NSString stringWithFormat: @"Delegate value : (%d);",pinIDSelected];
	NSLog([NSString stringWithFormat: @"Delegate value : (%d);",pinIDSelected]);
	
	 NSLog(@"delegate in Daddy");
	NSLog([NSString stringWithFormat: @"Delegate value in func is : (%d);",IDselected]);
	
	//Use IDselected from the delegate 
	NSString *callfunc;
	//callfunc=[NSString stringWithFormat: @"myFunction(%d);",recordID];
	callfunc=[NSString stringWithFormat: @"myFunction(%d);",IDselected];
	
	
		
	//Add the script stuff here......
	//We define the javascript function first
	[webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
	 "var idString='Thursday';"
	 "script.type = 'text/javascript';"
	 "script.text = \"function myFunction(id) { "
	 "var field = document.getElementById('test').innerHTML=id;"
	 " jQT.goTo('#Denmark','slide'); "
	 "field.value='Calling function - OK';"
	 "}\";"
	 "document.getElementsByTagName('head')[0].appendChild(script);"];
	
	//Now we call the javascript function - with the ID as a parameter (returned from the MKAnnotation_Click
	[webView stringByEvaluatingJavaScriptFromString:callfunc];
	
		
}

- (void) showMap:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
{
	NSString* myAnnID;
	
	MapViewController *view2=[[MapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	[view2 setDelegate:self];		//tell the modal map view, who its Daddy is...
	view2.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
	
	CLLocationCoordinate2D location2D;
	//float *latx=(float*)[arguments objectAtIndex:0];
	//float *laty=(float*)[arguments objectAtIndex:0];
	
	//location.latitude = 53.2793;
	//location.longitude = -9.0618;
	location2D.latitude = [[arguments objectAtIndex:1] doubleValue];
	location2D.longitude = [[arguments objectAtIndex:2] doubleValue];
	
	//location.latitude = latx;
	//location.longitude =laty;
		
	//Access the public property on the View
	
	view2.mycoordinate=location2D;
	
	//view2.Town = @"Limerick";
	//view2.ArrayLocations=@"53.7,-8.72,'1BALLINLOUGH';53.7,-8.81,'2CORK';53.7,-8.82,'3DUBLIN'";
	view2.ArrayLocations=(NSString*) [arguments objectAtIndex:5];
	view2.Town=(NSString*) [arguments objectAtIndex:3];
	view2.TownSubtitle=(NSString*) [arguments objectAtIndex:4];
	
	PhoneGapViewController* cont = (PhoneGapViewController*)[ super appViewController ];
	//childBrowser.supportedOrientations = cont.supportedOrientations;
	[ cont presentModalViewController:view2 animated:YES ];
	
	//NSString *url = (NSString*) [arguments objectAtIndex:0];
	
	//Returns from Modal view2....
	
	myAnnID=view2.AnnID;
	
	
	//int recordID=21;
	view2.SelectedID=222;
	int recordID=view2.SelectedID;				//Get the ID from the selected MKAnnotation
	
	
	//[childBrowser loadURL:url  ];
	[view2 release];
	
		
}

@end

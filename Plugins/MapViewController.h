//
//  MapView.h
//  FindPitch
//
//  Created by Joe Bloggs on 16/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@protocol MapViewControllerDelegate<NSObject>;
@required 
-(void)pinSelected:(int)pinIDSelected;
@end

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	NSNumber *currentPoint;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSNumber *currentPoint;




@end

@interface MapViewController : UIViewController<MKMapViewDelegate> {
	IBOutlet UITextField *addressField;
	IBOutlet UIButton *goButton;
	IBOutlet MKMapView *mapView;
	
	AddressAnnotation *addAnnotation;
	AddressAnnotation *addAnnotationx;
	
	NSString* ArrayLocations;
	NSString* Town;
	NSString* TownSubtitle;
	NSString* AnnID;
	int	SelectedID;
	CLLocationCoordinate2D mycoordinate;
	id <MapViewControllerDelegate> delegate;
	
		
}

@property (retain) NSString* ArrayLocations;
@property (retain) NSString* Town;
@property (retain) NSString* TownSubtitle;
@property (retain) NSString* AnnID;
@property (nonatomic) CLLocationCoordinate2D mycoordinate;
@property (readwrite,assign) int SelectedID;
@property (assign) id<MapViewControllerDelegate> delegate;


-(IBAction) showAddress;
-(IBAction) showVC2;
-(IBAction) goBack;
-(IBAction) showCurrentLocation;

-(CLLocationCoordinate2D) addressLocation;
-(void) showArgsAddress;
-(void)zoomToFitMapAnnotations;
-(IBAction)annotationViewClick;

@end


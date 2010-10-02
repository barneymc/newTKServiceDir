//MapBiew Controller

#import "MapViewController.h"
#import "PhoneGapViewController.h"




//#import "VC2.h"

@implementation AddressAnnotation

@synthesize coordinate;
@synthesize subtitle;
@synthesize title;
@synthesize currentPoint;

//- (NSString *)subtitle{
//	return @"Sub Title";
//}

//- (NSString *)title{
//	return @"TitleStuff";
//}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	title=@"StartTitle";
	subtitle=@"Subtitle";
	
	//subTitle=subtitleP;
	//[Title retain];
	
	
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end


@implementation MapViewController

@synthesize delegate;
@synthesize ArrayLocations;
@synthesize Town;
@synthesize TownSubtitle;
@synthesize AnnID;
@synthesize SelectedID;

//@synthesize latitudex;
//@synthesize longitudey;
@synthesize mycoordinate;

//-(CLLocationCoordinate2D) coordinate
//{
//	CLLocationCoordinate2D coord={self.latitudex,self.longitudey};
//	return coord;
//}

//-(void) setcoordinate:(

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

-(IBAction) showVC2{
	//VC2 *view2=[[VC2 alloc] initWithNibName:@"VC2" bundle:nil];
	//view2.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
	//[self presentModalViewController:view2 animated:YES];
	

}

-(IBAction)goBack
{
	[self dismissModalViewControllerAnimated:YES];	
	[[self delegate] pinSelected:2];
	
	
}

//Called by clicking on the SHOW button
//Fetches the location coordinates from Google by calling addressLocation
//before showing them on map
- (IBAction) showAddress {
	//Hide the keypad
	[addressField resignFirstResponder];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	//BMCA - rather than passing in the address and getting Google's LatLng
	//just set my own here.....
	//These LatLngs could be pass in via args from JavaScript...
	
	//addressLocation function is called - gets the co-ords from Google - and uses the coords here
	CLLocationCoordinate2D location = [self addressLocation];
	//CLLocationCoordinate2D location2D;  //this is the ViewControllers.mycoordinate Public property
	//location.latitude = mycoordinate.latitude;
	//location.longitude= mycoordinate.longitude;
	
	//location.longitude = -9.0618;
	region.span=span;
	region.center=location;
	
	
	//This removes any? existing annotations
	//So you can keep adding Annotations
	//if(addAnnotation != nil) {
	//	[mapView removeAnnotation:addAnnotation];
	//	[addAnnotation release];
	//	addAnnotation = nil;
	//}
	
	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
	[mapView addAnnotation:addAnnotation];
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	//[mapView selectAnnotation:mLodgeAnnotation animated:YES];
}



-(CLLocationCoordinate2D) addressLocation {
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
						   [addressField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	double latitude = 0.0;
	double longitude = 0.0;
	
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
	}
	else {
		//Show error
	}
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	
	return location;
}

//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
//	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
//	UIImage *pinImage=[[UIImage imageNamed:@"icon.png"];
//	annView.pinColor = MKPinAnnotationColorGreen;
//	annView.animatesDrop=TRUE;
//	annView.canShowCallout = YES;
//	annView.calloutOffset = CGPointMake(-5, 5);
//	return annView;
//}

//This custom view gets applied to all MKAnnotations.....just use ordinary pins for the moment
//Use calloutAccessoryControlTapped instead

//*** This ussed MKAnnotationView - use MKPinAnnotationView!!

//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(AddressAnnotation *) annotation{

//	int postag=0;
//  MKAnnotationView *CustannView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
   
//	UIImage *pinImage= [UIImage imageNamed:@"icon.png"];
//	[CustannView setImage:pinImage];
	
//	UIImageView *leftIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
//	CustannView.leftCalloutAccessoryView=leftIconView;
	
//	UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//	[rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
	//rightButton.tag=44;
//	NSLog([NSString stringWithFormat: @"currentPoint is (%d)",annotation.currentPoint]);
	//if ([[annotation title] isEqualToString:@"Current Location"]){
	//	postag=99999;
	//}
	//else{
	//	postag=[annotation.currentPoint intValue];
	//}
	//rightButton.tag=postag;
//	postag=2;
//	CustannView.rightCalloutAccessoryView=rightButton;
								 
						
								 
 //CustannView.pinColor = MKPinAnnotationColorGreen;
  //CustannView.animatesDrop=YES;
//  CustannView.canShowCallout = YES;
//  CustannView.calloutOffset = CGPointMake(-5, 5);
//  return CustannView;
//}
											  

								 
//handle the click event for the annotation - setting the javascript								 
-(IBAction)annotationViewClick:(id) sender{
	
	//NSLog(@" sender.UIButton Tag : currentPoint is %d ",[sender tag]);
	int nrButtonPressed=((UIButton *)sender).tag;
	NSLog([NSString stringWithFormat: @"Button pressed (%d);",nrButtonPressed]);
	NSLog(@"Clicked - raising protocal to delegate!");
	
	[[self delegate] pinSelected:222];		//child class sends protocol message to the delegate
	self.AnnID=@"A";
	self.SelectedID=213;
	[self dismissModalViewControllerAnimated:YES];	
								 
		
}
								 
- (IBAction)showCurrentLocation
{
	
	CLLocationCoordinate2D userLoc;
	userLoc.latitude = mapView.userLocation.location.coordinate.latitude;
	userLoc.longitude = mapView.userLocation.location.coordinate.longitude;
	mapView.region = MKCoordinateRegionMakeWithDistance(userLoc, 50000, 50000);
	
}


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	 [super viewDidLoad];
	 [self showArgsAddress];
	[self zoomToFitMapAnnotations];    //ensure all pins can be seen
  }


//This method gets called by viewDidLoad and sets the initial coordinates
//Uses the Public ViewController.mycoordinate property which is set by the calling function
//all the way back in the Javascript call
- (void) showArgsAddress{
	[addressField resignFirstResponder];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	
	//These LatLngs could be pass in via args from JavaScript...
	
	
	//CLLocationCoordinate2D location = [self addressLocation];
	CLLocationCoordinate2D location3D;
	location3D.latitude = mycoordinate.latitude;
	location3D.longitude = mycoordinate.longitude;
	region.span=span;
	region.center=location3D;
	
	if(addAnnotation != nil) {
		[mapView removeAnnotation:addAnnotation];
		[addAnnotation release];
		addAnnotation = nil;
	}
	
	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location3D];
	addAnnotation.title=self.Town;
	addAnnotation.subtitle=self.TownSubtitle;
	
	[mapView addAnnotation:addAnnotation];
	
	//Working with Arrays
	//locationPoints = [[NSMutableArray array] retain];
	//locationPoints = ["53.7,-8.72;53.7,-8.81;53.7,-8.68"];
	
	
	
	CLLocationCoordinate2D eventLocation;
	
	//Try initialising with a string and get the array from that string
	//NSString *liststring=@"53.7,-8.72,'BALLINLOUGH';53.7,-8.81,'CORK';53.7,-8.82,'DUBLIN'";		//Start off with a string
	//Check if there is a LocationArray...if there is parse the locations and display
	
	NSLog(@"ArrayLocs is %@",self.ArrayLocations);
	if ([self.ArrayLocations isEqualToString:@"-"]) {
			//Do nothing
		}
	else 
		{
		
	
		//Load arrayLocations from View.Property so it can be passed in via Javascript;
		NSString *liststring=self.ArrayLocations;
	
		NSArray *listlocations;
		listlocations=[liststring componentsSeparatedByString:@";"];    //Convert string to an array
	
		//We started with an array - handier if it was a string
		NSString *location;
		//NSArray *listlocations=[NSArray arrayWithObjects:@"53.7,-8.72",@"53.7,-8.81",@"53.7,-8.82",nil];
	
		NSArray *values;
		int i;
		int count;
	
	count=[listlocations count];
	for (i=0; i< count; i++) {
		NSLog(@"Element %i = %@",i,[listlocations objectAtIndex:i]);
		
		location=[listlocations objectAtIndex:i];				//"53,-8.4"	STRING
		values=[location componentsSeparatedByString:@","];		//[53,-8.4]	ARRAY
		NSLog(@"AllLocationValues is %@",values);
		NSLog(@" Label cord is %@", [values objectAtIndex:2]);		//CORK label		VALUE IN ARRAY
		
		eventLocation.latitude=	[[values objectAtIndex:0] doubleValue]; 
		eventLocation.longitude=[[values objectAtIndex:1] doubleValue];
		
		addAnnotationx=[[AddressAnnotation alloc] initWithCoordinate:eventLocation];
		
		addAnnotationx.currentPoint=i;
		[mapView addAnnotation:addAnnotationx];
		}
		
	}
	
	
	//--------------------------- Add a second coordinate
	// Can we get this from an Array of coordinates
	
	CLLocationCoordinate2D location3X;
	location3X.latitude =53.7435;
	location3X.longitude = -8.7246;
	//region.span=span;
	//region.center=location3D;
		
	addAnnotationx = [[AddressAnnotation alloc] initWithCoordinate:location3X];
	addAnnotationx.title=@"TestX";
	addAnnotationx.subtitle=@"TestX1";
	
	[mapView addAnnotation:addAnnotationx];
	
	
	//---------------------------------------------------------------------------------
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	mapView.showsUserLocation=YES;
	
	//[mapView selectAnnotation:mLodgeAnnotation animated:YES];
	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	//self.latitude=nil;
	//[self.longitude=nil];
	[Town release];
    [super dealloc];
}

-(void)zoomToFitMapAnnotations
{
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(AddressAnnotation* annotation in mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

@end

//
//  ViewController.m
//  MapCurrentLocation
//
//  Created by Mac Damian on 29.05.2013.
//  Copyright (c) 2013 MacBook Damian. All rights reserved.
//

#import "ViewController.h"
#define kTwoKilometers 2.0

@interface ViewController ()
{
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    BottomAddressView *_bottomView;
}

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) BottomAddressView *bottomView;

@end

@implementation ViewController
@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;
@synthesize geocoder = _geocoder;
@synthesize bottomView = _bottomView;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    NSLog(@"view did load");
    [self createBottomView];
    [self createMapView];
    
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"view did appear");
    [self startLocationManager];
    [super viewDidAppear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"view did disappear");
    [self stopLocationManager];
    [super viewDidDisappear:YES];
}

#pragma mark - Map View

- (void)updateCurrentRegionForCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion currentRegion = MKCoordinateRegionMakeWithDistance(coordinate, kTwoKilometers, kTwoKilometers);
    [self.mapView setRegion:currentRegion animated:YES];
}

#pragma mark - Location Manager

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil)
        _locationManager = [[CLLocationManager alloc] init];
    
    return _locationManager;
}

- (void)startLocationManager
{
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)stopLocationManager
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Location Manager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.bottomView.title.text = @"Ustalam adres...";
    
    // Get the most recent location update, the last one.
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D currentCoordinate = currentLocation.coordinate;
        
    [self updateCurrentRegionForCoordinate:currentCoordinate];
    [self translateLocationToNearAddress:currentLocation];
}

#pragma mark - Geocoder

- (CLGeocoder *)geocoder
{
    if (_geocoder == nil)
        _geocoder = [[CLGeocoder alloc] init];
    
    return _geocoder;
}

- (void)translateLocationToNearAddress:(CLLocation *)currentLocation
{
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks != nil)
        {
            CLPlacemark *currentPlaceMark = [placemarks lastObject];
            
            // ZIP, City, Street, Country.
            NSString *fullAddress = [NSString stringWithFormat:@"%@ %@, %@, %@",
                                     [currentPlaceMark.addressDictionary valueForKey:(NSString *)kABPersonAddressZIPKey],
                                     [currentPlaceMark.addressDictionary valueForKey:(NSString *)kABPersonAddressCityKey],
                                     [currentPlaceMark.addressDictionary valueForKey:(NSString *)kABPersonAddressStreetKey],
                                     [currentPlaceMark.addressDictionary valueForKey:(NSString *)kABPersonAddressCountryKey]];
            
            NSLog(@"Full Address: %@", fullAddress);
            [self updateAddress:fullAddress];
        }
    }];
}

- (void)updateAddress:(NSString *)address
{
    self.bottomView.title.text = @"Obecna lokalizacja:";
    self.bottomView.address.text = address;
}

#pragma mark - Create Subviews

- (void)createMapView
{
    float mapViewHeight = [UIScreen mainScreen].bounds.size.height - self.bottomView.frame.size.height;
    CGRect mapFrame = CGRectMake(0, 0, 320, mapViewHeight);
    self.mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    self.mapView.showsUserLocation = YES;
    
    [self.view addSubview:self.mapView];
}

- (void)createBottomView
{
    float bottomViewHeight = 80;
    CGFloat posY = [UIScreen mainScreen].bounds.size.height - bottomViewHeight;
    CGRect bottomFrame = CGRectMake(0, posY, 320.0, bottomViewHeight);
    self.bottomView = [[BottomAddressView alloc] initWithFrame:bottomFrame];    
    self.bottomView.title.text = @"Ustalam...";
    
    [self.view addSubview:self.bottomView];
}

#pragma mark - Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end

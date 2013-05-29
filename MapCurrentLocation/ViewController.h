//
//  ViewController.h
//  MapCurrentLocation
//
//  Created by Mac Damian on 29.05.2013.
//  Copyright (c) 2013 MacBook Damian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "BottomAddressView.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>
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

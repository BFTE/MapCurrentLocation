//
//  BottomAddressView.h
//  MapCurrentLocation
//
//  Created by Mac Damian on 29.05.2013.
//  Copyright (c) 2013 MacBook Damian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomAddressView : UIView
{
    UILabel *_title;
    UILabel *_address;
}

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *address;

@end

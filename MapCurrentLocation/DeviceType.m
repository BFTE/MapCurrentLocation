//
//  DeviceType.m
//  MapCurrentLocation
//
//  Created by Mac Damian on 29.05.2013.
//  Copyright (c) 2013 MacBook Damian. All rights reserved.
//

#import "DeviceType.h"

@implementation DeviceType

+ (BOOL)isIphone5
{
    BOOL isIphone5 = NO;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        CGSize size = [UIScreen mainScreen].bounds.size;
        if (size.height == 568.0 )
            isIphone5 = YES;
        else
            isIphone5 = NO;
    }
    
    return isIphone5;
}

@end

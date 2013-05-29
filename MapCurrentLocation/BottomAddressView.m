//
//  BottomAddressView.m
//  MapCurrentLocation
//
//  Created by Mac Damian on 29.05.2013.
//  Copyright (c) 2013 MacBook Damian. All rights reserved.
//

#import "BottomAddressView.h"

@implementation BottomAddressView

@synthesize title = _title;
@synthesize address = _address;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addLabelsToView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addLabelsToView
{
    float inset = 10.0;
    
    // Title.
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0 + inset, 0 + inset, 320.0 - inset, 12.0)];
    self.title.font = [UIFont boldSystemFontOfSize:12.0];
    
    // Address.
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(0 + inset, 12 + inset, 320.0 - inset, 45)];
    self.address.font = [UIFont systemFontOfSize:14.0];
    self.address.numberOfLines = 2;
    
    [self addSubview:self.title];
    [self addSubview:self.address];
}


// Draw lines on view to seperate it from map view.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, 0);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextMoveToPoint(context, 0, 1);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, 1);
    CGContextStrokePath(context);
}
@end

//
//  RCTMapManager.m
//  ReactNativeApp
//
//  Created by Andy on 16/9/18.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MapKit/MapKit.h>
#import "RCTViewManager.h"


@interface RCTMapManager : RCTViewManager

@end

@implementation RCTMapManager


RCT_EXPORT_MODULE();


RCT_EXPORT_VIEW_PROPERTY(pitchEnabled, BOOL);

RCT_EXPORT_VIEW_PROPERTY(onAnnotationDragStateChange, BOOL);


- (UIView *)view
{
  return [[MKMapView alloc] init];
}


@end

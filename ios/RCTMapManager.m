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
#import "RCTMap.h"


@interface RCTMapManager : RCTViewManager

@end

@implementation RCTMapManager


RCT_EXPORT_MODULE()


RCT_EXPORT_VIEW_PROPERTY(pitchEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(region, MKCoordinateRegion, RCTMap)
{
  [view setRegion:json ? [RCTConvert MKCoordinateRegion:json] : defaultView.region animated:YES];
  
  //if (json) {
    //[view setRegion:[RCTConvert MKCoordinateRegion:json] animated:YES];
  //}
}



- (UIView *)view
{
  RCTMap *map = [[RCTMap alloc] init];
  map.delegate = self;
  return map;
}


- (void)mapView:(RCTMap *)mapView regionDidChangeAnimated:(BOOL)animated
{
  if (!mapView.onChange) {
    return;
  }
  
  MKCoordinateRegion region = mapView.region;
  mapView.onChange(@{
                     @"region": @{
                         @"latitude": @(region.center.latitude),
                         @"longitude": @(region.center.longitude),
                         @"latitudeDelta": @(region.span.latitudeDelta),
                         @"longitudeDelta": @(region.span.longitudeDelta)
                         }
                     });
}


@end

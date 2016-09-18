//
//  CalendarManager.m
//  ReactNativeApp
//
//  Created by Andy on 16/9/18.
//  Copyright © 2016年 Facebook. All rights reserved.
//  See http://facebook.github.io/react-native/docs/native-modules-ios.html

#import "CalendarManager.h"
#import "RCTConvert.h"

// 发送事件给javascript
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"



@implementation CalendarManager



@synthesize bridge = _bridge;



RCT_EXPORT_MODULE();



// 支持的事件
/*
- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EventReminder"];
}
 */

// 发送事件到js
- (void)calendarEventReminderReceived:(NSNotification *)notification
{
  NSString *eventName = notification.userInfo[@"name"];
  NSLog(@"eventDispatcher %@", eventName);
  //[self sendEventWithName:@"EventReminder" body:@{ @"name": eventName }];
  [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name": eventName}];
}



// 导出常量
- (NSDictionary *)constantsToExport
{
  // key : value
  // js use  NativeModules.CalendarManager.firstDayOfTheWeek to call
  return @{
           @"firstDayOfTheWeek": @"Monday",
           @"lastDayOfTheWeek": @"Sunday",
           
           // 枚举
           @"statusBarAnimationNone": @(UIStatusBarAnimationNone),
           @"statusBarAnimationFade": @(UIStatusBarAnimationFade),
           @"statusBarAnimationSlide": @(UIStatusBarAnimationSlide)
           };
}



// 带参方法
RCT_EXPORT_METHOD(addEvent:(NSString *)name details:(NSDictionary *)details)
{
  NSString *location = [RCTConvert NSString:details[@"location"]];
  NSDate *time = [RCTConvert NSDate:details[@"time"]];
  NSString *description = [RCTConvert NSString:details[@"description"]];
  
  NSLog(@"name = %@ , location = %@ , time = %@ , description = %@", name, location, time, description);
}



// 带回调函数的方法
RCT_EXPORT_METHOD(findEvents:(RCTResponseSenderBlock)callback)
{
  NSArray *events = @[@"method A", @"method B", @"method C", @"method D"];
  callback(@[events]);
  
  // 此种写法，返回两个参数，第一个参数返回是否有误，第二个参数才返回数据
  //  callback(@[NSNull null], events]);
}



// 使用 promise 方式
RCT_EXPORT_METHOD(findEvents2:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  //  NSArray *events;  // reject
  NSArray *events = @[@"中", @"秋", @"节", @"快", @"乐"]; // resolve
  if (events) {
    resolve(events);
  } else {
    NSString *domain = @"com.yuexing.app.error";
    NSString *desc = NSLocalizedString(@"Unable to ...", @"");
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: desc };
    NSError *error = [NSError errorWithDomain:domain code:-101 userInfo:userInfo];
    
    reject(@"no_events", @"There were no events", error);
  }
}



@end


// 导出枚举类型
@implementation RCTConvert (StatusBarAnimation)


// 定义枚举转换
RCT_ENUM_CONVERTER(
                   // 类型
                   UIStatusBarAnimation,
                   // 键值映射
                   (@{
                      @"statusBarAnimationNone" : @(UIStatusBarAnimationNone),
                      @"statusBarAnimationFade" : @(UIStatusBarAnimationFade),
                      @"statusBarAnimationSlide" : @(UIStatusBarAnimationSlide)
                      }),
                   // 默认值
                   UIStatusBarAnimationNone,
                   // int 转换
                   integerValue)


@end

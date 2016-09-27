//
//  RootViewController.m
//  ReactNativeApp
//
//  Created by Andy on 16/9/27.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"


@implementation RootViewController

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(goToNative)
{
  NSLog(@"goToNative here---------");
  LoginViewController *loginView = [[LoginViewController alloc] init];
  
//  [[UIApplication sharedApplication] keyWindow].rootViewController = loginView;
  
  [((UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController) pushViewController:loginView animated:YES];
}

@end

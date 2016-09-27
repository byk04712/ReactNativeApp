#import "AppDelegate.h"

#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"
#import "LoginViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;
  
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"ReactNativeApp"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.title = @"主界面";
  rootViewController.view = rootView;
  
  self.navController = [[UINavigationController alloc] init];
  [self.navController pushViewController:rootView.reactViewController animated:YES];
  [self.window addSubview:self.navController.view];
  
  self.window.rootViewController = self.navController;
  [self.window makeKeyAndVisible];
  
//  [self addSubViews];
  return YES;
}

// 添加views
- (void)addSubViews
{
  UIButton *button = [[UIButton alloc] init];
  button.frame = CGRectMake(50, 100, 120, 45);
  button.backgroundColor = [UIColor purpleColor];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
  label.text = @"去原生界面";
  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = [UIColor whiteColor];
  
  [button addSubview:label];
  [button addTarget:self action:@selector(goToPage:) forControlEvents:UIControlEventTouchDown];
  
  [self.window addSubview:button];
}

- (void)goToPage:(id)sender
{
  NSLog(@"响应按钮点击事件");
  [self toPage];
}

- (void)toPage
{
    NSLog(@"toPage ");
  LoginViewController *loginView = [[LoginViewController alloc] init];
//  loginView.title = @"原生界面";
//  [self.navController pushViewController:loginView animated:YES];
  
//  [self.navController showViewController:loginView sender:loginView];
//  [self.navController presentViewController:loginView animated:YES completion:nil];
//  self.window.rootViewController = loginView;
  
//  [[UIApplication sharedApplication] keyWindow].rootViewController = loginView;
  [((UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController) pushViewController:loginView animated:YES];
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(toNative)
{
  NSLog(@"来到了AppDelegate");
  [self toPage];
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end

//
//  AppDelegate.m
//  TwitterLaunchDemo
//
//  Created by zz go on 2016/10/22.
//  Copyright © 2016年 zzgo. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 设置主窗口,并设置跟控制器
    self.window = [UIWindow new];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //self.window.rootViewController = [ViewController new];
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    UIViewController *myVC = [story instantiateViewControllerWithIdentifier:@"MyVC"];
    self.window.rootViewController = myVC;
    
    [self.window makeKeyAndVisible];
    
    UIView *view=self.window.rootViewController.view;
    
    CALayer *logoLayer=[CALayer new];
    logoLayer.bounds=CGRectMake(0, 0, 100, 100);
    logoLayer.position=view.center;
    logoLayer.contents=(__bridge id _Nullable)([UIImage imageNamed:@"twitter"].CGImage);
    
    view.layer.mask=logoLayer;
    
    UIView *shelterView=[[UIView alloc] initWithFrame:view.frame];
    //mask，即图片遮罩的颜色
    shelterView.backgroundColor=[self hz_colorFromHexString:@"56abe4"];
    [view addSubview:shelterView];
    //背景色
    self.window.backgroundColor=[UIColor whiteColor];
    
    CAKeyframeAnimation *logoAnimation=[CAKeyframeAnimation new];
    logoAnimation.keyPath=@"bounds";
    logoAnimation.beginTime=CACurrentMediaTime()+1;
    logoAnimation.duration=1;
    logoAnimation.keyTimes=@[@0,@0.4,@1];
    
    NSValue *value1=[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    NSValue *value2=[NSValue valueWithCGRect:CGRectMake(0, 0, 85, 85)];
    NSValue *value3=[NSValue valueWithCGRect:CGRectMake(0, 0, 5000, 5000)];
    logoAnimation.values=@[value1, value2,value3 ];
    logoAnimation.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    logoAnimation.removedOnCompletion= NO;
    logoAnimation.fillMode=kCAFillModeForwards;
    
    [logoLayer addAnimation:logoAnimation forKey:@"zoomAnimation"];
    
    
    CAKeyframeAnimation *mainAnimation=[CAKeyframeAnimation new];
    mainAnimation.keyPath=@"transform";
    mainAnimation.beginTime=CACurrentMediaTime()+1.1;
    mainAnimation.duration=0.6;
    mainAnimation.keyTimes=@[@0,@0.5,@1];
    NSValue *mainValue1=[NSValue valueWithCATransform3D:CATransform3DIdentity];
    NSValue *mainValue2=[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)];
    NSValue *mainValue3=[NSValue valueWithCATransform3D:CATransform3DIdentity];
    mainAnimation.values=@[mainValue1,mainValue2,mainValue3];
    
    [view.layer addAnimation:mainAnimation forKey:@"transformAnimation"];
    view.layer.transform=CATransform3DIdentity;
    
    [UIView animateWithDuration:0.3 delay:1.4 options:UIViewAnimationOptionCurveLinear animations:^{
        shelterView.alpha=0;
    } completion:^(BOOL finished) {
        [shelterView removeFromSuperview];
        view.layer.mask=nil;
    }];
    return YES;
}

- (UIColor *)hz_colorFromHexString:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString
                       stringWithFormat:@"%@%@%@%@%@%@", [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF) / 255.0f;
    float green = ((baseValue >> 16) & 0xFF) / 255.0f;
    float blue = ((baseValue >> 8) & 0xFF) / 255.0f;
    float alpha = ((baseValue >> 0) & 0xFF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

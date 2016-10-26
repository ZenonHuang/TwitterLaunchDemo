//
//  HZLaunchAnimation.h
//  TwitterLaunchDemo
//
//  Created by zz go on 2016/10/26.
//  Copyright © 2016年 zzgo. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface HZLaunchView : UIView

/**
 禁止使用 init 或 new 的方法来初始化,必须给定参数
 */
- ( instancetype)init UNAVAILABLE_ATTRIBUTE;
+ ( instancetype)new UNAVAILABLE_ATTRIBUTE;


/**
 初始化HZLaunchView

 @param icon  图片
 @param color 背景颜色

 @return launchView
 */
- (instancetype)initWithIconImage:(UIImage *)icon backgroundColor:(UIColor *)color;


/**
 启动动画

 @param duration 动画时间
 */
- (void)startAnimationWithDuration:(NSTimeInterval)duration;


/**
 启动动画

 @param duration          动画时间
 @param completionHandler 回调
 */
- (void)startAnimationWithDuration:(NSTimeInterval)duration CompletionHandler:(void (^)())completionHandler;


/**
 icon的size,默认为(60,60)
 */
@property (nonatomic, assign) CGSize iconStartSize;

@end

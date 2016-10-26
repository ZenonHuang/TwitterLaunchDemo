//
//  HZLaunchAnimation.h
//  TwitterLaunchDemo
//
//  Created by zz go on 2016/10/26.
//  Copyright © 2016年 zzgo. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface HZLaunchView : UIView

- (instancetype)initWithIconImage:(UIImage *)icon backgroundColor:(UIColor *)color;


/**
 *  Call to start the animation.
 */
- (void)startAnimationWithDuration:(NSTimeInterval)duration;

/**
 *  Call to start the animation with completion handler.
 */
- (void)startAnimationWithDuration:(NSTimeInterval)duration CompletionHandler:(void (^)())completionHandler;

/**
 *  The starting size of the centred icon.
 */
@property (nonatomic, assign) CGSize iconStartSize;



@end

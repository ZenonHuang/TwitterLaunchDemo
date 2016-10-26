//
//  HZLaunchAnimation.m
//  TwitterLaunchDemo
//
//  Created by zz go on 2016/10/26.
//  Copyright © 2016年 zzgo. All rights reserved.
//

#import "HZLaunchView.h"


@interface HZLaunchView()
/**
 *  The animation applied to the icon
 */
@property (nonatomic, strong) CAAnimation *iconAnimation;
@property (nonatomic, strong) UIColor *iconColor;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation HZLaunchView

#pragma mark - init

- (instancetype)initWithIconImage:(UIImage *)icon iconColor:(UIColor *)color backgroundColor:(UIColor *)bgColor
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = bgColor;
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        iconImageView.tintColor = color;
        iconImageView.frame = CGRectMake(0, 0, self.iconStartSize.width, self.iconStartSize.height);
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        iconImageView.center = self.center;
        
        [self addSubview:iconImageView];
        
        _iconImageView = iconImageView;
    }
    return self;
}

- (instancetype)initWithIconImage:(UIImage *)icon backgroundColor:(UIColor *)color
{
    return [self initWithIconImage:icon iconColor:[UIColor whiteColor] backgroundColor:color];
}

#pragma mark - public methods

- (void)startAnimationWithDuration:(NSTimeInterval)duration
{
    [self startAnimationWithDuration:duration CompletionHandler:nil];
}

- (void)startAnimationWithDuration:(NSTimeInterval)duration CompletionHandler:(void (^)())completionHandler
{
    __block __weak typeof(self) weakSelf = self;
    
    if (!duration) {
        duration=1.0f;
    }
    
    CGFloat shrinkDuration = duration * 0.3;
    CGFloat growDuration = duration * 0.7;
    
    [UIView animateWithDuration:shrinkDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
        weakSelf.iconImageView.transform = scaleTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:growDuration animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
            weakSelf.iconImageView.transform = scaleTransform;
            weakSelf.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            if (completionHandler) {
                completionHandler();
            }
        }];
    }];
}

#pragma mark - getter

- (CGSize)iconStartSize
{
    if (!_iconStartSize.height) {
        _iconStartSize = CGSizeMake(60, 60);
    }
    return _iconStartSize;
}

- (CAAnimation *)iconAnimation
{
    if (!_iconAnimation) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@1, @0.9, @300];
        animation.keyTimes = @[@0, @0.4, @1];
        //默认为1
        animation.duration = 1.0;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        _iconAnimation = animation;
    }
    return _iconAnimation;
}

@end

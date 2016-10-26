//
//  ViewController.m
//  TwitterLaunchDemo
//
//  Created by zz go on 2016/10/22.
//  Copyright © 2016年 zzgo. All rights reserved.
//


#import "ViewController.h"
#import "HZLaunchView.h"

static NSString * const kTwitterColor = @"4099FF";
static NSString * const kTwitterImageName = @"twitter";

@interface ViewController ()

@property (nonatomic, strong) HZLaunchView *launchView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.launchView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.launchView startAnimationWithDuration:3];
        });
}
#pragma mark - getter
-(HZLaunchView *)launchView{
    if (!_launchView) {
        UIColor *color = [self hz_colorFromHexString:kTwitterColor];
        _launchView=[[HZLaunchView alloc] initWithIconImage:[UIImage imageNamed:kTwitterImageName] backgroundColor:color];
    }
    return _launchView;
}
#pragma mark - private
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
@end

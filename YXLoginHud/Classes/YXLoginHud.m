//
//  YXLoginHud.m
//  SVProgress
//
//  Created by 帅  于 on 2017/5/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YXLoginHud.h"
#import "YXLoginHudView.h"

@implementation YXLoginHud

+ (void)showErrorMessage:(NSString *)message{
    [YXLoginHud removeLoginHudView];
    YXLoginHudView *bgView = [[YXLoginHudView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    message = message != nil ? message:@"出错了哦";
    [bgView showErrorMessage:message];
}

+ (void)showSuccessMessage:(NSString *)message completion:(void (^)(BOOL isFinished))block{
    [YXLoginHud removeLoginHudView];
    YXLoginHudView *bgView = [[YXLoginHudView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    message = message != nil ? message:@"出错了哦";
    [bgView showSuccessMessage:message completion:block];
}

+ (void)removeLoginHudView{
    for (id view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[YXLoginHudView class]]) {
            UIView *hudView = (YXLoginHudView *)view;
            [hudView removeFromSuperview];
        }
    }
}
@end

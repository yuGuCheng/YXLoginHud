//
//  YXLoginHudView.h
//  SVProgress
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YXLoginHudView : UIView

@property (nonatomic,copy) void(^completionBlock) (BOOL isFinished);

- (void)showErrorMessage:(NSString *)message;

- (void)showSuccessMessage:(NSString *)message completion:(void (^)(BOOL isFinished))block;

@end

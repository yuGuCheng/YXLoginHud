//
//  YXLoginHud.h
//  SVProgress
//
//  Created by 帅  于 on 2017/5/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXLoginHud : NSObject

+ (void)showErrorMessage:(NSString *)message;

+ (void)showSuccessMessage:(NSString *)message completion:(void (^)(BOOL isFinished))block;

@end


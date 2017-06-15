//
//  YXLoginHudView.m
//  SVProgress
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YXLoginHudView.h"
#import "Masonry.h"


@interface  ContainerView : UIView

@property (nonatomic,strong) UIImageView *imgVIcon;
@property (nonatomic,strong) UILabel *lblMessage;

@end

@interface YXLoginHudView()
{
    BOOL _isTouch;
    BOOL _isFinished;
}

@property (nonatomic, strong) ContainerView *cView;

@end

@implementation YXLoginHudView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    CGFloat width = [UIScreen mainScreen].bounds.size.width -90;
    __weak typeof(self) weakSelf = self;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self addSubview:self.cView];
    [self.cView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.width.mas_lessThanOrEqualTo(width);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isTouch = YES;
    [self dismisswithCompletion:self.completionBlock];
}

#pragma mark -- public
- (void)showErrorMessage:(NSString *)message{
    self.cView.lblMessage.text = message;
    self.cView.imgVIcon.image = [UIImage imageNamed:@"hudError"];
    [self showView];
    if (!_isTouch) {
        [self delayDismissInSecond:1.5 completion:nil];
    }
}
- (void)showSuccessMessage:(NSString *)message completion:(void (^)(BOOL))block{
    self.cView.lblMessage.text = message;
    self.cView.imgVIcon.image = [UIImage imageNamed:@"successSend"];
    [self showView];
    if (!_isTouch) {
        [self delayDismissInSecond:1.5 completion:block];
    }else{
        if (_completionBlock) {
            self.completionBlock = block;
        }
    }
    
}
- (void)showView{
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.cView.layer.shouldRasterize = YES;
        self.cView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
        [UIView animateWithDuration:0.2 animations:^{
            self.cView.alpha = 1;
            self.cView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.1 animations:^{
                self.cView.alpha = 1;
                self.cView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.cView.alpha = 1;
                    self.cView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                } completion:^(BOOL finished2) {
//                    self.cView.layer.shouldRasterize = NO;
                }];
                
            }];
        }];
    });
}

- (void)dismisswithCompletion:(void (^)(BOOL isFinished))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        self.cView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.cView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.cView.alpha = 0;
                self.cView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
                [self cleanUp];
            } completion:block];
        }];
    });
}
- (void)delayDismissInSecond:(float)second completion:(void (^)(BOOL isFinished))block{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismisswithCompletion:block];
    });
}
- (void)cleanUp{
    [self.cView removeFromSuperview];
    [self removeFromSuperview];
}

- (ContainerView *)cView{
    if (_cView == nil) {
        _cView = [[ContainerView alloc]init];
        _cView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _cView.alpha = 0;
    }
    return _cView;
}
@end


@implementation ContainerView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    __weak typeof(self) weakSelf =self;
    
    [self addSubview:self.imgVIcon];
    [self.imgVIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(weakSelf).offset(18);
    }];
    
    [self addSubview:self.lblMessage];
    [self.lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(13);
        make.right.equalTo(weakSelf).offset(-13);
        make.top.equalTo(weakSelf.imgVIcon.mas_bottom).offset(8);
        make.bottom.equalTo(weakSelf).offset(-10);
    }];
    
}


- (UILabel *)lblMessage{
    if (_lblMessage == nil) {
        _lblMessage = [[UILabel alloc]init];
        _lblMessage.font = [UIFont systemFontOfSize:15.0f];
        _lblMessage.numberOfLines = 0;
        _lblMessage.textColor = [UIColor whiteColor];
        //        _lblMessage.backgroundColor = [UIColor redColor];
        //        _lblMessage.textAlignment =NSTextAlignmentCenter;
    }
    return _lblMessage;
}

- (UIImageView *)imgVIcon{
    if (_imgVIcon == nil) {
        _imgVIcon = [[UIImageView alloc]init];
    }
    return _imgVIcon;
}

@end

//
//  MBProgressHUD+JSExtension.m
//  JSCoffer
//
//  Created by lijie on 2015/8/16.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import "MBProgressHUD+JSExtension.h"

@implementation MBProgressHUD (JSExtension)

#pragma mark 显示成功/错误信息
+ (void)showSuccess:(NSString *)success inView:(UIView *)view
{
    [self showCustomIcon:@"success.png" title:success inView:view];
}
+ (void)showError:(NSString *)error inView:(UIView *)view{
    [self showCustomIcon:@"error.png" title:error inView:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message inView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message inView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

/**
 *  进度条View
 */
+ (MBProgressHUD *)showProgressInView:(UIView *)view progressModel:(MBProgressHUDMode)model text:(NSString *)text{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = model;
    hud.label.text = text;
    return hud;
}

#pragma mark 加载视图--loadingView
+(void)showLoadView{
    [self showLoadInView:nil];
}
+(void)showLoadInView:(UIView *)view{
    [self showMessage:@"Loading..." inView:view];
}

//快速显示一条提示信息
+ (void)showAutoMessage:(NSString *)message{
    
    [self showAutoMessage:message inView:nil];
}


//自动消失提示，无图
+ (void)showAutoMessage:(NSString *)message inView:(UIView *)view{
    [self showMessage:message inView:view remainTime:0.9 model:MBProgressHUDModeText];
}

//自定义停留时间，有图
+(void)showIconMessage:(NSString *)message inView:(UIView *)view remainTime:(CGFloat)time{
    [self showMessage:message inView:view remainTime:time model:MBProgressHUDModeIndeterminate];
}

//自定义停留时间，无图
+(void)showMessage:(NSString *)message inView:(UIView *)view remainTime:(CGFloat)time{
    [self showMessage:message inView:view remainTime:time model:MBProgressHUDModeText];
}

+(void)showMessage:(NSString *)message inView:(UIView *)view remainTime:(CGFloat)time model:(MBProgressHUDMode)model{
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    //模式
    hud.mode = model;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // X秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showCustomIcon:(NSString *)iconName title:(NSString *)title inView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = title;
    // 设置图片
    if ([iconName isEqualToString:@"error.png"] || [iconName isEqualToString:@"success.png"]) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", iconName]]];
    }else{
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:0.9];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end

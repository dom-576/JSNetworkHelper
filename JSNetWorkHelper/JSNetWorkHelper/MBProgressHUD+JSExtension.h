//
//  MBProgressHUD+JSExtension.h
//  JSCoffer
//
//  Created by lijie on 2015/8/16.
//  Copyright © 2017年 LiJie. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (JSExtension)

/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success inView:(UIView *)view;

/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error inView:(UIView *)view;

/**
 *  文字+菊花提示,不自动消失
 *
 *  @param message 要显示的文字
 *  @return 返回使用
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;

/**
 *  文字+菊花提示,不自动消失
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message inView:(UIView *)view;

/**
 *  进度条View
 *
 *  @param view     要添加的View
 *  @param model    进度条的样式
 *  @param text     显示的文字
 *
 *  @return 返回使用
 */
+ (MBProgressHUD *)showProgressInView:(UIView *)view progressModel:(MBProgressHUDMode)model text:(NSString *)text;

/**
 * 加载视图 不自动消失
 */
+(void)showLoadView;

/**
 *  加载视图 不自动消失
 *
 *  @param view 要添加的View
 */
+ (void)showLoadInView:(UIView *)view;

/**
 *  快速显示一条提示信息
 *
 *  @param message 要显示的文字
 */
+ (void)showAutoMessage:(NSString *)message;

/**
 *  自动消失提示，无图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 */
+ (void)showAutoMessage:(NSString *)message inView:(UIView *)view;

/**
 *  自定义停留时间，有图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *  @param time    停留时间
 */
+(void)showIconMessage:(NSString *)message inView:(UIView *)view remainTime:(CGFloat)time;

/**
 *  自定义停留时间，无图
 *
 *  @param message 要显示的文字
 *  @param view 要添加的View
 *  @param time 停留时间
 */
+(void)showMessage:(NSString *)message inView:(UIView *)view remainTime:(CGFloat)time;

/**
 *  自定义图片的提示，1s后自动消息
 *
 *  @param iconName 要显示的文字
 *  @param title 图片地址(建议不要太大的图片)
 *  @param view 要添加的view
 */
+ (void)showCustomIcon:(NSString *)iconName title:(NSString *)title inView:(UIView *)view;

/**
 *  隐藏ProgressView
 *
 *  @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;

/**
 *  快速从window中隐藏ProgressView
 */
+ (void)hideHUD;

@end

//
//  JLNetWorkHelper.h
//  LJ_Project
//
//  Created by lijie on 2016/3/1.
//  Copyright © 2016年 lijie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger{
    
    StatusUnknown = 0,//未知状态
    StatusNotReachable,//无网状态
    StatusReachableViaWWAN,//手机网络
    StatusReachableViaWiFi,//Wifi网络
    
} NetworkStatus;

@interface JSNetWorkHelper : NSObject

/**
 有网YES, 无网:NO
 */
+ (BOOL)isReachable;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isReachableWWAN;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isReachableWiFi;

/**
 * 监听网络状态的变化
 *
 */
+ (void)checkingNetworkResult:(void (^)(NetworkStatus))result;

/**
 * GET请求
 */
+ (id)GET:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 * POST请求
 */
+ (id)POST:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *POST上传文件
 */
+ (id)POST:(NSString *)url parameter:(NSDictionary *)parameter data:(NSData *)fileData fieldName:(NSString *)fieldName fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  NSData上传文件
 */
+ (id)uploadDataWithUrlString:(NSString *)urlString data:(NSData *)data progress:(void(^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  NSURL上传文件
 */
+ (id)uploadFileWithUrlString:(NSString *)urlString
                      fileUrl:(NSURL *)fileUrl
                     progress:(void(^)(NSProgress *uploadProgress))progress
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure;


@end

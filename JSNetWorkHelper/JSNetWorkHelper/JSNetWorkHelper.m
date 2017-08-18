//
//  JLNetWorkHelper.m
//  LJ_Project
//
//  Created by lijie on 2016/3/1.
//  Copyright © 2016年 lijie. All rights reserved.
//

#import "JSNetWorkHelper.h"
#import "AFNetWorking.h"
#import "MBProgressHUD+JSExtension.h"

#define kWindow [UIApplication sharedApplication].delegate.window

@implementation JSNetWorkHelper

#pragma mark -- 网络状态 --
+ (BOOL)isReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isReachableWWAN {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isReachableWiFi {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/***********/
+ (AFHTTPSessionManager *)sharedAFManager{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        /**分别设置请求以及相应的序列化器*/
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        /**设置相应的缓存策略*/
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        /**设置请求超时时间*/
        manager.requestSerializer.timeoutInterval = 10;
        
        /**安全策略*/
        manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
        /**接收参数类型*/
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/javascript", nil];
    });
    return manager;
}

/**
 *  GET
 */
+ (id)GET:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    return [[self sharedAFManager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 *  POST
 */
+ (id)POST:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    return [[self sharedAFManager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^void(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^void(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 *
 * POST上传文件（data）
 *
 *@param url  服务器url
 *@param parameter 参数
 *@param fileData 文件data(可以是图片，音频，视频，其他文件等类型)
 *@param fieldName 服务器上对应的该文件放置位置
 *@param fileName 文件名  文件名不可重复，一般用时间
 *@param mimeType 文件类型
 *@param success 完成结果 成功:response; 失败:error
 
 */
+ (id)POST:(NSString *)url
 parameter:(NSDictionary *)parameter
      data:(NSData *)fileData fieldName:(NSString *)fieldName
  fileName:(NSString *)fileName mimeType:(NSString *)mimeType
   success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    return  [[self sharedAFManager] POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*
         *也可用路径获取文件
         ******************
         NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"image.png" withExtension:nil];
         [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
         ******************
         */
        [formData appendPartWithFileData:fileData name:fieldName fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


/**
 *  NSData上传文件
 */
+ (id)uploadDataWithUrlString:(NSString *)urlString
                         data:(NSData *)data progress:(void(^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    return [[self sharedAFManager] uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        !error ? success(responseObject) : failure(error);
    }];
}


/**
 *  NSURL上传文件
 */
+ (id)uploadFileWithUrlString:(NSString *)urlString
                      fileUrl:(NSURL *)fileUrl
                     progress:(void(^)(NSProgress *uploadProgress))progress
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    return  [[self sharedAFManager] uploadTaskWithRequest:request fromFile:fileUrl progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) progress(uploadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        !error ? success(responseObject) : failure(error);
    }];
}


/**
 * 监听网络状态的变化
 *@param result 结果回调
 */
+ (void)checkingNetworkResult:(void (^)(NetworkStatus))result {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager startMonitoring];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    //[MBProgressHUD showAutoMessage:@"未知网络" inView:kWindow];
                    result ? result(StatusUnknown) :nil;
                    NSLog(@"未知网络");
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    [MBProgressHUD showAutoMessage:@"网络未连接,请检查" inView:kWindow];
                    result ? result(StatusNotReachable) :nil;
                    NSLog(@"没有网络(断网)");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    [MBProgressHUD showAutoMessage:@"当前网络为蜂窝网络" inView:kWindow];
                    result ? result(StatusReachableViaWWAN) :nil;
                    NSLog(@"手机自带蜂窝网络");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                {
                    [MBProgressHUD showAutoMessage:@"当前网络为WiFi" inView:kWindow];
                    result ? result(StatusReachableViaWiFi) :nil;
                    NSLog(@"WIFI");
                }
                    break;
            }
        }];
    });
}

@end

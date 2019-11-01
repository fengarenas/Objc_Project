//
//  QUImageUploader.m
//  Questions
//
//  Created by fengj on 2019/5/6.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "DFImageUploader.h"
#import <AFHTTPSessionManager.h>
#import "UIImage+Ex.h"

@implementation DFImageUploader

/* 评论/建议 图片上传接口 */
+ (void)uploadCommentImg:(UIImage *)img complete:(uploadImageComplete)complete {
    NSString *url = @"app/file/comment/picture";
    NSString *name = @"picture";
    [self uploadImg:img url:url name:name progress:nil complete:complete];
}


/* 头像上传接口 */
+ (void)uploadAvatarImg:(UIImage *)img complete:(uploadImageComplete)complete {
    NSString *url = @"app/file/user/avatar";
    NSString *name = @"avatar";
    [self uploadImg:img url:url name:name progress:nil complete:complete];
}

+ (void)uploadImg:(UIImage *)img
              url:(NSString *)url
             name:(NSString *)name
         progress:(nullable void (^)(NSProgress * _Nonnull Progress))uploadProgress
         complete:(uploadImageComplete)complete {
    if (!img) {
        return;
    }
    if (!url.length) {
        return;
    }
    if (!name.length) {
        return;
    }
    
    //后台压缩图片
    [UIImage resetSizeOfImageData:img maxSize:1024 complete:^(NSData * _Nonnull data) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",@((NSInteger)[NSDate new].timeIntervalSince1970)];
        
#ifdef DEBUG
        NSString *theUrl = [NSString stringWithFormat:@"%@%@",kBaseURL,url];
        NSLog(@"upload url:%@ name:%@",theUrl,name);
#endif
        
        AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        
        [mgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
        }
         progress:^(NSProgress * _Nonnull Progress) {
             NSLog(@"上传进度:%.2f",Progress.completedUnitCount*1.f/Progress.totalUnitCount);
             if (uploadProgress) {
                 uploadProgress(Progress);
             }
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              //0成功 ，-1失败 ，2未登录，3鉴权失败
              NSNumber *errorCode = [responseObject objectForKey:@"retCode"];
              NSString *errorMessage = [responseObject objectForKey:@"retMsg"];
              
              if ([errorCode isEqual:@0]) {
                  NSDictionary *dict = responseObject[@"result"];
                  //数据解析 验证
                  if (![dict isKindOfClass:NSDictionary.class]) {
                      if (complete) {
                          complete(nil,errorMessage);
                      }
                      return ;
                  }
                  
                  NSString *fileUrl;
                  if ([dict.allKeys containsObject:@"fileUrl"]) {
                      fileUrl = [dict objectForKey:@"fileUrl"];
                  }
                  
                  if (complete) {
                      complete(fileUrl.length?fileUrl:nil,nil);
                  }
              } else {
                  
                  if (complete) {
                      complete(nil,errorMessage);
                  }
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (complete) {
                  complete(nil,error.localizedDescription);
              }
          }];
    }];
    
}

@end

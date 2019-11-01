//
//  UIImageView+Ex.h
//  Questions
//
//  Created by fengj on 2019/5/2.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+YYWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Ex)

/*
 
 imageURL 图片url
 placeholder 占位图
 ratio 按宽高比保留图片
 radius 圆角弧度
 */
- (void)setImageWithURL:(NSString *)imageURL
            placeholder:(UIImage *)placeholder
                  ratio:(CGFloat)ratio
                 radius:(CGFloat)radius;

- (void)setImageWithURL:(NSString *)imageURL
            placeholder:(UIImage *)placeholder
                  ratio:(CGFloat)ratio
                 radius:(CGFloat)radius
               progress:(YYWebImageProgressBlock)progress
             completion:(YYWebImageCompletionBlock)completion;

//下载头像图片 并进行1:1的裁剪处理 设置成圆角图片
- (void)setHeadIconImageWithURL:(NSString *)imageURL
            placeholder:(UIImage *)placeholder;
@end

NS_ASSUME_NONNULL_END

//
//  UIImage+Ex.h
//  Questions
//
//  Created by fengj on 2019/5/3.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^resizeComplete)(NSData *data);


@interface UIImage (Ex)
//解决图片Orientation问题
- (UIImage *)fixOrientation;

//按指定比例裁剪
- (UIImage *)qu_imageByCropToRatio:(CGFloat)ratio radius:(CGFloat)radius;

//裁剪成头像   1:1  从中间裁剪
- (UIImage *)qu_imageForHeadIconImage;

//压缩图片到指定大小(单位KB)
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;
+ (void)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize complete:(resizeComplete)complete;


+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

//
//  UIImage+Ex.m
//  Questions
//
//  Created by fengj on 2019/5/3.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "UIImage+Ex.h"
#import <UIImage+YYAdd.h>
#import <SDWebImage/UIImage+GIF.h>

@implementation UIImage (Ex)


- (UIImage *)qu_imageForHeadIconImage {

    //这里裁剪前 需要考虑 调整image的 UIImageOrientation 属性
    UIImage *image = [self fixOrientation];
    
    CGFloat imgW = image.size.width;
    CGFloat imgH = image.size.height;
    
    CGFloat x,y,newImgLength;
    
    if (imgW>imgH) {
        newImgLength = imgH;
        x = (imgW - newImgLength)/2.f;
        y = 0;
    } else {
        newImgLength = imgW;
        x = 0;
        y = (imgH - newImgLength)/2.f;
    }
    
    UIImage *ratioImage = [image imageByCropToRect:CGRectMake(x, y, newImgLength, newImgLength)];
    ratioImage = [ratioImage imageByRoundCornerRadius:newImgLength/2.f];
    
    return ratioImage;
}

- (UIImage *)qu_imageByCropToRatio:(CGFloat)ratio radius:(CGFloat)radius {
    //这里裁剪前 需要考虑 调整image的 UIImageOrientation 属性
    UIImage *image = [self fixOrientation];
    
    CGFloat imgW = image.size.width;
    CGFloat imgH = image.size.height;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat newImgW = image.size.width;
    CGFloat newImgH = image.size.width / ratio;
    
    if (newImgH>imgH) {
        newImgH = imgH;
        newImgW = newImgH * ratio;
        x = (imgW - newImgW)/2.f;
        y = 0;
    }
    
    CGRect rect = CGRectMake(x,y,newImgW,newImgH);
    
    UIImage *ratioImage = [image imageByCropToRect:rect];
    
    ratioImage = [ratioImage imageByRoundCornerRadius:radius];
    
    return ratioImage;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+ (void)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize complete:(resizeComplete)complete {
    if (!complete) {
        return;
    }
    if (![NSThread isMainThread]) {
        complete([self resetSizeOfImageData:sourceImage maxSize:maxSize]);
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            complete([self resetSizeOfImageData:sourceImage maxSize:maxSize]);
        });
    }
    
}

#pragma mark - 压缩图片到指定大小(单位KB)
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    __block NSData *canCompressMinData = [NSData data];//当无法压缩到指定大小时，用于存储当前能够压缩到的最小值数据。
    [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize resultBlock:^(NSData *finallData, NSData *tempData) {
        finallImageData = finallData;
        canCompressMinData = tempData;
    }];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize resultBlock:^(NSData *finallData, NSData *tempData) {
            finallImageData = finallData;
            canCompressMinData = tempData;
        }];
    }
    //如果分辨率已经无法再降低，则直接使用能够压缩的那个最小值即可
    if (finallImageData.length==0) {
        finallImageData = canCompressMinData;
    }
    return finallImageData;
}
#pragma mark 调整图片分辨率/尺寸（等比例缩放）
///调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    //    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 二分法
///二分法，block回调中finallData长度不为零表示最终压缩到了指定的大小，如果为零则表示压缩不到指定大小。tempData表示当前能够压缩到的最小值。
+ (void)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize resultBlock:(void(^)(NSData *finallData, NSData *tempData))block {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        //        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    NSData *d = [NSData data];
    if (tempData.length==0) {
        d = finallImageData;
    }
    if (block) {
        block(tempData, d);
    }
    //    return tempData;
}

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
           return [UIImage sd_imageWithGIFData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_imageWithGIFData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_imageWithGIFData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

@end

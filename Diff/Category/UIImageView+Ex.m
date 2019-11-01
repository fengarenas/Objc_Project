//
//  UIImageView+Ex.m
//  Questions
//
//  Created by fengj on 2019/5/2.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "UIImageView+Ex.h"
#import <UIImage+YYAdd.h>
#import "UIImage+Ex.h"

@implementation UIImageView (Ex)


- (void)setImageWithURL:(NSString *)imageURL
            placeholder:(UIImage *)placeholder
                  ratio:(CGFloat)ratio
                 radius:(CGFloat)radius
               progress:(YYWebImageProgressBlock)progress
             completion:(YYWebImageCompletionBlock)completion {
    YYWebImageManager *mgr = [YYWebImageManager sharedManager];
    NSString *ratioImgUrlStr = [NSString stringWithFormat:@"%@",@(ratio)];
    
    NSURL *url = [NSURL URLWithString:imageURL];
    NSURL *ratioImgUrl = [url URLByAppendingPathComponent:ratioImgUrlStr];
    NSString *ratioImgCacheKey = [mgr cacheKeyForURL:ratioImgUrl];
    UIImage *cachedImg = [mgr.cache getImageForKey:ratioImgCacheKey];
    if (cachedImg) {
        [self setImageWithURL:ratioImgUrl placeholder:placeholder?placeholder:nil options:kNilOptions progress:progress?progress:nil transform:nil completion:completion?completion:nil];
    } else {
        
        __weak typeof(self) wself = self;
        [self setImageWithURL:imageURL placeholder:placeholder options:YYWebImageOptionAvoidSetImage manager:nil progress:progress?progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
            return image;
        } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            
            if (completion) {
                completion(image,url,from,stage,error);
            }
            if (!image || error) {
                return ;
            }
            __strong typeof(wself) sself = wself;
            
            //这里裁剪前 需要考虑 调整image的 UIImageOrientation 属性
            image = [image qu_imageByCropToRatio:ratio radius:radius];
            
            YYWebImageManager *mgr = [YYWebImageManager sharedManager];
            NSString *ratioImgUrlStr = [NSString stringWithFormat:@"%@",@(ratio)];
            NSURL *ratioImgUrl = [url URLByAppendingPathComponent:ratioImgUrlStr];
            NSString *ratioImgCacheKey = [mgr cacheKeyForURL:ratioImgUrl];

            [mgr.cache setImage:image forKey:ratioImgCacheKey];
            
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    sself.image = image;
                });
            } else {
                sself.image = image;
            }
            
        }];
        
    }
    
}

- (void)setImageWithURL:(NSString *)imageURL
            placeholder:(UIImage *)placeholder
                  ratio:(CGFloat)ratio
                 radius:(CGFloat)radius {
    
    [self setImageWithURL:imageURL placeholder:placeholder ratio:ratio radius:radius progress:nil completion:nil];
}

- (void)setHeadIconImageWithURL:(NSString *)imageURL
                    placeholder:(UIImage *)placeholder {
    __weak typeof(self) wself = self;
    [self setImageWithURL:imageURL placeholder:placeholder options:kNilOptions manager:nil progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        
        
        //这里裁剪前 需要考虑 调整image的 UIImageOrientation 属性
        image = [image fixOrientation];
        
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
        
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
}

@end

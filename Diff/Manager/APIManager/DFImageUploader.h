//
//  QUImageUploader.h
//  Questions
//
//  Created by fengj on 2019/5/6.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^uploadImageComplete)(NSString * _Nullable imgUrl,NSString * _Nullable errorMsg);//上传图片回调

NS_ASSUME_NONNULL_BEGIN

@interface DFImageUploader : NSObject

/* 评论/建议 图片上传接口 */
+ (void)uploadCommentImg:(UIImage *)img complete:(uploadImageComplete)complete;

/* 头像上传接口 */
+ (void)uploadAvatarImg:(UIImage *)img complete:(uploadImageComplete)complete;

@end

NS_ASSUME_NONNULL_END

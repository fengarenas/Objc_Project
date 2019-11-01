//
//  UIAlertViewEx.h
//  QRCode
//
//  Created by mac on 14-1-27.
//  Copyright (c) 2014年 QRCode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView(UIAlertViewEx)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertWithCompleteBlock:(CompleteBlock) block;


@end
